package jp.flutter.app

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.RemoteMessage
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import io.objectbox.BoxStore
import jp.flutter.app.objectbox.ObjectBox
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import jp.flutter.app.LocalMessageData

class MyFirebaseMessagingService : FlutterFirebaseMessagingService() {
    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)

        // Example decryption placeholder
        val body = message.data["encryptedBody"] ?: message.notification?.body

        // Guarda el mensaje en ObjectBox
        val store: BoxStore = ObjectBox.get().store
        val box = store.boxFor(LocalMessageData::class.java)
        val entity = LocalMessageData(text = body)
        box.put(entity)

        val total = box.count()
        Log.d("MyFirebaseMessaging", "💾 Mensajes guardados en ObjectBox: $total")

        // Notificar a Flutter si la UI está activa
        FlutterEngineCache.getInstance().get("main")?.let { engine ->
            Handler(Looper.getMainLooper()).post {
                MethodChannel(engine.dartExecutor.binaryMessenger, "sync_channel")
                    .invokeMethod("dataUpdated", body)
            }
        }

        // Muestra la notificación nativamente
        val builder = NotificationCompat.Builder(this, "default")
            .setContentTitle(message.notification?.title ?: "")
            .setContentText(body)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setAutoCancel(true)
        if (NotificationManagerCompat.from(this).areNotificationsEnabled()) {
            NotificationManagerCompat.from(this).notify(entity.id.toInt(), builder.build())
        } else {
            // Opcional: puedes loguear o manejar la falta de permiso aquí
            Log.w("MyFirebaseMessaging", "🔕 Notificaciones deshabilitadas por el usuario.")
        }
    }
}
