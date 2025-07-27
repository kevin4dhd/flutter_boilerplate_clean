# Hybrid Notification Example

This document shows how to handle FCM messages natively while sharing the ObjectBox database between Flutter and native code.

## Android
- `MyFirebaseMessagingService` intercepts FCM messages, decrypts the payload and stores it using ObjectBox.
- Notifications are displayed with `NotificationCompat`.
- The shared ObjectBox schema is stored at `shared/objectbox-model.json` and referenced from Android using the `objectbox` Gradle block.
- `MainActivity` initializes ObjectBox on startup.

## iOS
- A `Notification Service Extension` decrypts incoming notifications before they are shown.
- The extension is located in `ios/NotificationService` and modifies the body field.
- The extension also stores the decrypted text using ObjectBox so the main app sees the message immediately.

Both platforms store messages in the same ObjectBox model so Flutter can access them via the data layer.

The home screen listens on `sync_channel` to refresh messages in real time when the native service saves a new entry.

Messages are loaded via pagination on Flutter. Native services send the message text over the `sync_channel` so Flutter can insert it using the shared database.
