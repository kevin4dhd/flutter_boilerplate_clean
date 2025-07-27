package jp.flutter.app

import io.objectbox.annotation.Entity
import io.objectbox.annotation.Id

@Entity
data class LocalMessageData(
    @Id var id: Long = 0,
    var text: String? = null
)
