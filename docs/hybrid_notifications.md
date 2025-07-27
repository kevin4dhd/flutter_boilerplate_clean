# Hybrid Notification Example

This document shows how to handle FCM messages natively while sharing the SQLite database between Flutter and native code.

## Android
- `MyFirebaseMessagingService` intercepts FCM messages, decrypts the payload and stores it using SQLite.
- Notifications are displayed with `NotificationCompat`.
- The shared SQLite schema is stored at `the shared database file` and referenced from Android using the SQLite helpers.
- `MainActivity` initializes SQLite on startup.

## iOS
- A `Notification Service Extension` decrypts incoming notifications before they are shown.
- The extension is located in `ios/NotificationService` and modifies the body field.
- The extension also stores the decrypted text using SQLite so the main app sees the message immediately.

Both platforms store messages in the same SQLite model so Flutter can access them via the data layer.

The home screen listens on `sync_channel` to refresh messages in real time when the native service saves a new entry.

Messages are loaded via pagination on Flutter. Native services send the message text over the `sync_channel` so Flutter can insert it using the shared database.
