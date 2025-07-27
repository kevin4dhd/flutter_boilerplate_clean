import Foundation
import ObjectBox

@Entity()
class LocalMessageData {
    var id: Id = 0
    var text: String?

    required init() {}

    init(text: String?) {
        self.text = text
    }
}
