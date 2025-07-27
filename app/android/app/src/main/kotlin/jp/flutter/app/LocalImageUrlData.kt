package jp.flutter.app

import io.objectbox.annotation.Entity
import io.objectbox.annotation.Id

@Entity
data class LocalImageUrlData(
    @Id var id: Long = 0,
    var origin: String? = null,
    var sm: String? = null,
    var md: String? = null,
    var lg: String? = null
)
