package jp.flutter.app.sqlite

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import jp.flutter.app.DatabaseConstants
import android.util.Log
import java.io.File

class DatabaseHelper(context: Context) : SQLiteOpenHelper(
    context,
    getDatabasePath(context),
    null,
    2
) {
    companion object {
        private fun getDatabasePath(context: Context): String {
            val flutterDir = File(context.filesDir.parentFile, "app_flutter")
            if (!flutterDir.exists()) {
                flutterDir.mkdirs()
            }
            val path = flutterDir.resolve(DatabaseConstants.DATABASE_NAME)
            Log.d("SQLite DB", "Unified database path: $path")
            return path.path
        }
    }

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(
            "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, money TEXT, gender INTEGER, birthday INTEGER)"
        )
        db.execSQL(
            "CREATE TABLE image_url(id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, origin TEXT, sm TEXT, md TEXT, lg TEXT, is_avatar INTEGER)"
        )
        db.execSQL(
            "CREATE TABLE message(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, created_at INTEGER)"
        )
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        if (oldVersion < 2) {
            db.execSQL("ALTER TABLE message ADD COLUMN created_at INTEGER")
        }
    }
}
