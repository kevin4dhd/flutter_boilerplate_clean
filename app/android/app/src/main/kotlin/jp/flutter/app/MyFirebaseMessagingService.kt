package jp.flutter.app

import android.content.ContentValues
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.RemoteMessage
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import jp.flutter.app.sqlite.DatabaseHelper

class MyFirebaseMessagingService : FlutterFirebaseMessagingService() {
    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        val body = message.data["encryptedBody"] ?: message.notification?.body

        val db = DatabaseHelper(this).writableDatabase
        val values = ContentValues().apply {
            put("text", body)
            put("created_at", System.currentTimeMillis())
        }
        val id = db.insert("message", null, values)

        val cursor = db.rawQuery("SELECT COUNT(*) FROM message", null)
        cursor.moveToFirst()
        val total = cursor.getLong(0)
        cursor.close()
        Log.d("MyFirebaseMessaging", "💾 Mensajes guardados en SQLite: $total")

        FlutterEngineCache.getInstance().get("main")?.let { engine ->
            Handler(Looper.getMainLooper()).post {
                MethodChannel(engine.dartExecutor.binaryMessenger, "sync_channel")
                    .invokeMethod("dataUpdated", body)
            }
        }

        val builder = NotificationCompat.Builder(this, "default")
            .setContentTitle(message.notification?.title ?: "")
            .setContentText(body)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setAutoCancel(true)
        if (NotificationManagerCompat.from(this).areNotificationsEnabled()) {
            NotificationManagerCompat.from(this).notify(id.toInt(), builder.build())
        } else {
            Log.w("MyFirebaseMessaging", "🔕 Notificaciones deshabilitadas por el usuario.")
        }
    }
}
