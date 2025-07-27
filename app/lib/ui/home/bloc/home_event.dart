import 'dart:async';

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'home_event.freezed.dart';

abstract class HomeEvent extends BaseBlocEvent {
  const HomeEvent();
}

@freezed
class HomePageInitiated extends HomeEvent with _$HomePageInitiated {
  const factory HomePageInitiated() = _HomePageInitiated;
}

@freezed
class HomePageRefreshed extends HomeEvent with _$HomePageRefreshed {
  const factory HomePageRefreshed({
    required Completer<void> completer,
  }) = _HomePageRefreshed;
}

@freezed
class UserLoadMore extends HomeEvent with _$UserLoadMore {
  const factory UserLoadMore() = _UserLoadMore;
}

@freezed
class MessagesLoadMore extends HomeEvent with _$MessagesLoadMore {
  const factory MessagesLoadMore() = _MessagesLoadMore;
}

@freezed
class MessagesUpdated extends HomeEvent with _$MessagesUpdated {
  const factory MessagesUpdated(Message message) = _MessagesUpdated;
}
