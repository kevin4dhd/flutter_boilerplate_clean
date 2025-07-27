package jp.flutter.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import jp.flutter.app.sqlite.DatabaseHelper

class MainActivity : FlutterActivity() {
    private var methodChannel: MethodChannel? = null
    private lateinit var dbHelper: DatabaseHelper

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        dbHelper = DatabaseHelper(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "sync_channel")
        FlutterEngineCache.getInstance().put("main", flutterEngine)
    }

    fun notifyDataUpdated() {
        methodChannel?.invokeMethod("dataUpdated", null)
    }
}
