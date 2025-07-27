class LocalMessageData {
  LocalMessageData({this.id = 0, this.text});

  int id;
  String? text;

  Map<String, Object?> toMap() => {
        'id': id,
        'text': text,
      };

  factory LocalMessageData.fromMap(Map<String, Object?> map) => LocalMessageData(
        id: map['id'] as int? ?? 0,
        text: map['text'] as String?,
      );
}
