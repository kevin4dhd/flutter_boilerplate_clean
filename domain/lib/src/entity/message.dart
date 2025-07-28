import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @Default(0) int id,
    @Default('') String text,
    @Default(Message.defaultCreatedAt) DateTime? createdAt,
  }) = _Message;

  static const DateTime? defaultCreatedAt = null;
}
