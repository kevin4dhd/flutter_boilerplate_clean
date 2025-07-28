package jp.flutter.app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.ContentValues
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.RemoteInput
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import jp.flutter.app.sqlite.DatabaseHelper

class NotificationReplyReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (ACTION_REPLY == intent.action) {
            val results = RemoteInput.getResultsFromIntent(intent)
            val message = results?.getCharSequence(KEY_TEXT_REPLY)?.toString()
            if (!message.isNullOrEmpty()) {
                val db = DatabaseHelper(context).writableDatabase
                val values = ContentValues().apply {
                    put("text", message)
                    put("created_at", System.currentTimeMillis())
                }
                val id = db.insert("message", null, values)

                FlutterEngineCache.getInstance().get("main")?.let { engine ->
                    Handler(Looper.getMainLooper()).post {
                        MethodChannel(engine.dartExecutor.binaryMessenger, "sync_channel")
                            .invokeMethod("dataUpdated", message)
                    }
                }

                val confirmBuilder = NotificationCompat.Builder(context, "default")
                    .setSmallIcon(android.R.drawable.ic_dialog_info)
                    .setContentText(message)
                    .setAutoCancel(true)
                val notificationId = id.toInt()
                if (NotificationManagerCompat.from(context).areNotificationsEnabled()) {
                    NotificationManagerCompat.from(context).notify(notificationId, confirmBuilder.build())
                }
            }
        }
    }

    companion object {
        const val ACTION_REPLY = "jp.flutter.app.ACTION_REPLY"
        const val KEY_TEXT_REPLY = "KEY_TEXT_REPLY"
    }
}
