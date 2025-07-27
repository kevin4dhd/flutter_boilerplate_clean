package jp.flutter.app

data class LocalUserData(
    var id: Long = 0,
    var email: String? = null,
    var money: String? = null,
    var gender: Long = 0,
    var birthday: Long = 0,
    var avatar: LocalImageUrlData? = null,
    var photos: List<LocalImageUrlData> = emptyList()
)
