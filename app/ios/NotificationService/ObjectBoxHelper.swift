import Foundation
import ObjectBox

enum ObjectBoxHelper {
    private static var store: Store?

    static func ensureInitialized() {
        if store != nil { return }
        if let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: DatabaseConstants.appGroup) {
            let url = container.appendingPathComponent(DatabaseConstants.databaseName)
            do {
                store = try Store(directoryPath: url.path)
            } catch {
                print("ObjectBox init error: \(error)")
            }
        }
    }

    static func getBox<T>(_ type: T.Type) -> Box<T>? where T: __EntityRelatable {
        ensureInitialized()
        return store?.box(for: type)
    }
}
