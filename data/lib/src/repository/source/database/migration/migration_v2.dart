import 'package:sqflite/sqflite.dart';

Future<void> migrateV2(Database db, int oldVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE message ADD COLUMN created_at INTEGER');
  }
}
