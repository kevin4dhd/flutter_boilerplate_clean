package jp.flutter.app.objectbox

import android.content.Context
import io.objectbox.BoxStore
import jp.flutter.app.DatabaseConstants
import jp.flutter.app.MyObjectBox
import android.util.Log
import java.io.File

object ObjectBox {
    lateinit var store: BoxStore
        private set

    fun init(context: Context) {
        val flutterDir = File(context.filesDir.parentFile, "app_flutter")
        if (!flutterDir.exists()) {
            flutterDir.mkdirs()
        }
        val dbPath = flutterDir.resolve(DatabaseConstants.DATABASE_NAME)
        Log.d("ObjectBox DB", "Unified database path: $dbPath")
        store = MyObjectBox.builder()
            .androidContext(context.applicationContext)
            .directory(dbPath)
            .build()
    }

    fun get(): ObjectBox = this
}
