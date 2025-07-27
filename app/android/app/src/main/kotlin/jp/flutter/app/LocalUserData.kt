package jp.flutter.app

import io.objectbox.annotation.Entity
import io.objectbox.annotation.Id
import io.objectbox.relation.ToMany
import io.objectbox.relation.ToOne

@Entity
data class LocalUserData(
    @Id var id: Long = 0,
    var email: String? = null,
    var money: String? = null,
    var gender: Long = 0,
    var birthday: Long = 0
) {
    // Relaciones
    lateinit var avatar: ToOne<LocalImageUrlData>

    lateinit var photos: ToMany<LocalImageUrlData>
}