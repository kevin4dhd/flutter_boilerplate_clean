import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:domain/domain.dart';

import '../../../../data.dart';
import 'model/local_message_data.dart';

@LazySingleton()
class AppDatabase {
  AppDatabase(this.database);

  final Database database;
  final _userStreamController =
      StreamController<List<LocalUserData>>.broadcast();

  Future<int> putUser(LocalUserData user) async {
    final id = await database.insert('user', user.toMap());
    user.id = id;
    if (user.avatar != null) {
      await database.insert('image_url', {
        ...user.avatar!.toMap(),
        'user_id': id,
        'is_avatar': 1,
      });
    }
    for (final photo in user.photos) {
      await database.insert('image_url', {
        ...photo.toMap(),
        'user_id': id,
        'is_avatar': 0,
      });
    }
    await _notifyUsersUpdated();
    return id;
  }

  Stream<List<LocalUserData>> getUsersStream() => _userStreamController.stream;

  Future<List<LocalUserData>> getUsers() async {
    final users = <LocalUserData>[];
    final maps = await database.query('user');
    for (final map in maps) {
      final id = map['id'] as int;
      final avatarMaps = await database.query('image_url',
          where: 'user_id=? AND is_avatar=1', whereArgs: [id]);
      final photoMaps = await database.query('image_url',
          where: 'user_id=? AND is_avatar=0', whereArgs: [id]);
      users.add(LocalUserData.fromMap(map,
          avatar: avatarMaps.isNotEmpty
              ? LocalImageUrlData.fromMap(avatarMaps.first)
              : null,
          photos:
              photoMaps.map((e) => LocalImageUrlData.fromMap(e)).toList()));
    }
    return users;
  }

  Future<LocalUserData?> getUser(int id) async {
    final maps = await database.query('user', where: 'id=?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    final avatarMaps = await database.query('image_url',
        where: 'user_id=? AND is_avatar=1', whereArgs: [id]);
    final photoMaps = await database.query('image_url',
        where: 'user_id=? AND is_avatar=0', whereArgs: [id]);
    return LocalUserData.fromMap(maps.first,
        avatar: avatarMaps.isNotEmpty
            ? LocalImageUrlData.fromMap(avatarMaps.first)
            : null,
        photos: photoMaps.map((e) => LocalImageUrlData.fromMap(e)).toList());
  }

  Future<bool> deleteImageUrl(int id) async {
    final count =
        await database.delete('image_url', where: 'id=?', whereArgs: [id]);
    await _notifyUsersUpdated();
    return count > 0;
  }

  Future<int> deleteAllUsersAndImageUrls() async {
    await database.delete('image_url');
    final count = await database.delete('user');
    await _notifyUsersUpdated();
    return count;
  }

  Future<int> putMessage(LocalMessageData message) async {
    final id = await database.insert('message', message.toMap());
    message.id = id;
    return id;
  }

  Future<PagedList<LocalMessageData>> getMessages({
    required int page,
    required int limit,
  }) async {
    final offset = (page - 1) * limit;
    final maps =
        await database.query('message', limit: limit, offset: offset);
    final items = maps.map(LocalMessageData.fromMap).toList();
    final next = items.length < limit ? null : page + 1;
    return PagedList(
      data: items,
      next: next,
      offset: offset,
    );
  }

  Future<void> _notifyUsersUpdated() async {
    final users = await getUsers();
    _userStreamController.add(users);
  }
}
