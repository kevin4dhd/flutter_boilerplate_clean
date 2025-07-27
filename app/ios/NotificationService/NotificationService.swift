import UserNotifications
import ObjectBox

class NotificationService: UNNotificationServiceExtension {
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)!
        if let encrypted = bestAttemptContent.userInfo["encryptedBody"] as? String {
            bestAttemptContent.body = decrypt(encrypted)
        }

        if let box: Box<LocalMessageData> = ObjectBoxHelper.getBox(LocalMessageData.self) {
            let entity = LocalMessageData(text: bestAttemptContent.body)
            try? box.put(entity)
        }

        contentHandler(bestAttemptContent)
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
    }

    private func decrypt(_ text: String) -> String {
        // TODO: implement decryption logic
        return text
    }
}
