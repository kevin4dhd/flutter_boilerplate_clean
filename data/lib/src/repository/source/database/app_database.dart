import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import '../../../../data.dart';
import 'model/local_message_data.dart';
import 'package:domain/domain.dart';

@LazySingleton()
class AppDatabase {
  AppDatabase(this.store);

  final Store store;

  int putUser(LocalUserData user) {
    return store.box<LocalUserData>().put(user);
  }

  Stream<List<LocalUserData>> getUsersStream() {
    return store
        .box<LocalUserData>()
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  List<LocalUserData> getUsers() {
    return store.box<LocalUserData>().getAll();
  }

  LocalUserData? getUser(int id) {
    return store.box<LocalUserData>().get(id);
  }

  bool deleteImageUrl(int id) {
    return store.box<LocalImageUrlData>().remove(id);
  }

  int deleteAllUsersAndImageUrls() {
    store.box<LocalImageUrlData>().removeAll();

    return store.box<LocalUserData>().removeAll();
  }

  int putMessage(LocalMessageData message) {
    return store.box<LocalMessageData>().put(message);
  }

  PagedList<LocalMessageData> getMessages({required int page, required int limit}) {
    final box = store.box<LocalMessageData>();
    final query = box.query().build();
    final offset = (page - 1) * limit;
    final items = query.find(offset: offset, limit: limit);
    query.close();
    final next = items.length < limit ? null : page + 1;
    return PagedList(
      data: items,
      next: next,
      offset: offset,
    );
  }
}
