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
                sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS message(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, created_at INTEGER)", nil, nil, nil)
                sqlite3_exec(db, "ALTER TABLE message ADD COLUMN created_at INTEGER", nil, nil, nil)
            }
        }
    }

    static func insertMessage(_ text: String?) {
        ensureInitialized()
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, "INSERT INTO message(text, created_at) VALUES(?, ?)", -1, &stmt, nil) == SQLITE_OK {
            if let t = text {
                sqlite3_bind_text(stmt, 1, t, -1, SQLITE_TRANSIENT)
            } else {
                sqlite3_bind_null(stmt, 1)
            }
            let now = Int64(Date().timeIntervalSince1970 * 1000)
            sqlite3_bind_int64(stmt, 2, now)
            sqlite3_step(stmt)
        }
        sqlite3_finalize(stmt)
    }
}
