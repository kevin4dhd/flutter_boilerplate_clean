import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)!
        if let encrypted = bestAttemptContent.userInfo["encryptedBody"] as? String {
            bestAttemptContent.body = decrypt(encrypted)
        }

        SqliteHelper.insertMessage(bestAttemptContent.body)

        contentHandler(bestAttemptContent)
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
    }

    private func decrypt(_ text: String) -> String {
        return text
    }
}
