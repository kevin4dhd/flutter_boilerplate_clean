import Foundation
import SQLite3

enum SqliteHelper {
    private static var db: OpaquePointer?

    static func ensureInitialized() {
        if db != nil { return }
        if let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: DatabaseConstants.appGroup) {
            let url = container.appendingPathComponent(DatabaseConstants.databaseName)
            if sqlite3_open(url.path, &db) != SQLITE_OK {
                print("SQLite init error")
            } else {
                sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS message(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT)", nil, nil, nil)
            }
        }
    }

    static func insertMessage(_ text: String?) {
        ensureInitialized()
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, "INSERT INTO message(text) VALUES(?)", -1, &stmt, nil) == SQLITE_OK {
            if let t = text {
                sqlite3_bind_text(stmt, 1, t, -1, SQLITE_TRANSIENT)
            } else {
                sqlite3_bind_null(stmt, 1)
            }
            sqlite3_step(stmt)
        }
        sqlite3_finalize(stmt)
    }
}
