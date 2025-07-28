class LocalMessageData {
  LocalMessageData({this.id = 0, this.text, this.createdAt});

  int id;
  String? text;
  int? createdAt;

  Map<String, Object?> toMap() => {
        'id': id,
        'text': text,
        'created_at': createdAt,
      };

  factory LocalMessageData.fromMap(Map<String, Object?> map) => LocalMessageData(
        id: map['id'] as int? ?? 0,
        text: map['text'] as String?,
        createdAt: map['created_at'] as int?,
      );
}
