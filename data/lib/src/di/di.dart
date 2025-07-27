import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'di.config.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Database> getDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, DatabaseConstants.databaseName);
    print('SQLite DB Path: $path');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE user(\n"
            "id INTEGER PRIMARY KEY AUTOINCREMENT,\n"
            "email TEXT,\n"
            "money TEXT,\n"
            "gender INTEGER,\n"
            "birthday INTEGER\n"
            ")");
        await db.execute("CREATE TABLE image_url(\n"
            "id INTEGER PRIMARY KEY AUTOINCREMENT,\n"
            "user_id INTEGER,\n"
            "origin TEXT,\n"
            "sm TEXT,\n"
            "md TEXT,\n"
            "lg TEXT,\n"
            "is_avatar INTEGER\n"
            ")");
        await db.execute("CREATE TABLE message(\n"
            "id INTEGER PRIMARY KEY AUTOINCREMENT,\n"
            "text TEXT\n"
            ")");
      },
    );
  }
}

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection() => getIt.init();
