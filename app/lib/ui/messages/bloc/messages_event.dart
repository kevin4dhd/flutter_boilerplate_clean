import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'messages_event.freezed.dart';

abstract class MessagesEvent extends BaseBlocEvent {
  const MessagesEvent();
}

@freezed
class MessagesPageInitiated extends MessagesEvent with _$MessagesPageInitiated {
  const factory MessagesPageInitiated() = _MessagesPageInitiated;
}

@freezed
class MessagesLoadMore extends MessagesEvent with _$MessagesLoadMore {
  const factory MessagesLoadMore() = _MessagesLoadMore;
}

@freezed
class MessagesUpdated extends MessagesEvent with _$MessagesUpdated {
  const factory MessagesUpdated(Message message) = _MessagesUpdated;
}
