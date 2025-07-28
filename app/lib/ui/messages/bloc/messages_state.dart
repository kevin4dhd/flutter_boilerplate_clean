import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'messages_state.freezed.dart';

@freezed
class MessagesState extends BaseBlocState with _$MessagesState {
  factory MessagesState({
    @Default(LoadMoreOutput<Message>(data: <Message>[]))
    LoadMoreOutput<Message> messages,
  }) = _MessagesState;
}
