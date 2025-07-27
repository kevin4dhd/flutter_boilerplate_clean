package jp.flutter.app.objectbox

import android.content.Context
import io.objectbox.BoxStore
import io.objectbox.android.AndroidObjectBrowser
import jp.flutter.app.DatabaseConstants
import jp.flutter.app.MyObjectBox
import io.objectbox.android.BuildConfig as ObjBuildConfig

object ObjectBox {
    lateinit var store: BoxStore
        private set

    fun init(context: Context) {
        store = MyObjectBox.builder()
            .androidContext(context.applicationContext)
            .directory(context.filesDir.resolve(DatabaseConstants.DATABASE_NAME))
            .build()

        if (ObjBuildConfig.DEBUG) {
            AndroidObjectBrowser(store).start(context.applicationContext)
        }
    }

    fun get(): ObjectBox = this
}
