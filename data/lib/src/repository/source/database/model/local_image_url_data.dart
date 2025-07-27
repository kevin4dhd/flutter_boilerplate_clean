class LocalImageUrlData {
  LocalImageUrlData({
    this.id,
    this.origin,
    this.sm,
    this.md,
    this.lg,
  });

  int? id;
  String? origin;
  String? sm;
  String? md;
  String? lg;

  Map<String, Object?> toMap() => {
        'id': id,
        'origin': origin,
        'sm': sm,
        'md': md,
        'lg': lg,
      };

  factory LocalImageUrlData.fromMap(Map<String, Object?> map) => LocalImageUrlData(
        id: map['id'] as int?,
        origin: map['origin'] as String?,
        sm: map['sm'] as String?,
        md: map['md'] as String?,
        lg: map['lg'] as String?,
      );

  @override
  int get hashCode {
    return id.hashCode ^ origin.hashCode ^ sm.hashCode ^ md.hashCode ^ lg.hashCode;
  }

  @override
  String toString() {
    return 'LocalImageUrlData(id: \$id, origin: \$origin, sm: \$sm, md: \$md, lg: \$lg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocalImageUrlData &&
        other.id == id &&
        other.origin == origin &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg;
  }
}
