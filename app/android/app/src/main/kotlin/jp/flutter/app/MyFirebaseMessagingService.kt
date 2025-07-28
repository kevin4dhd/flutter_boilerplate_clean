package jp.flutter.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.ContentValues
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.app.PendingIntent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.RemoteInput
import com.google.firebase.messaging.RemoteMessage
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import jp.flutter.app.sqlite.DatabaseHelper

class MyFirebaseMessagingService : FlutterFirebaseMessagingService() {
    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        createNotificationChannel()

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

        val replyIntent = Intent(this, NotificationReplyReceiver::class.java).apply {
            action = NotificationReplyReceiver.ACTION_REPLY
        }
        val replyPendingIntent = PendingIntent.getBroadcast(
            this,
            id.toInt(),
            replyIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or if (Build.VERSION.SDK_INT >= 31) PendingIntent.FLAG_MUTABLE else 0
        )

        val remoteInput = RemoteInput.Builder(NotificationReplyReceiver.KEY_TEXT_REPLY)
            .setLabel("Responder")
            .build()

        val replyAction = NotificationCompat.Action.Builder(
            android.R.drawable.ic_menu_send,
            "Responder",
            replyPendingIntent
        )
            .addRemoteInput(remoteInput)
            .setAllowGeneratedReplies(true)
            .build()

        val builder = NotificationCompat.Builder(this, "default")
            .setContentTitle(message.notification?.title ?: "")
            .setContentText(body)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setAutoCancel(true)
            .addAction(replyAction)
        if (NotificationManagerCompat.from(this).areNotificationsEnabled()) {
            NotificationManagerCompat.from(this).notify(id.toInt(), builder.build())
        } else {
            Log.w("MyFirebaseMessaging", "🔕 Notificaciones deshabilitadas por el usuario.")
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Mensajes"
            val descriptionText = "Canal para notificaciones de mensajes"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel("default", name, importance).apply {
                description = descriptionText
            }

            val notificationManager: NotificationManager =
                getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
