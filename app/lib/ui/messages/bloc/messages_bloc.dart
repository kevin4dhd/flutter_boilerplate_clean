import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'messages.dart';

@Injectable()
class MessagesBloc extends BaseBloc<MessagesEvent, MessagesState> {
  MessagesBloc(
    this._getMessagesUseCase,
    this._loadMoreMessagesUseCase,
  ) : super(MessagesState()) {
    on<MessagesPageInitiated>(
      _onMessagesPageInitiated,
      transformer: log(),
    );
    on<MessagesLoadMore>(
      _onMessagesLoadMore,
      transformer: log(),
    );
    on<MessagesUpdated>(
      _onMessagesUpdated,
      transformer: log(),
    );
  }

  final GetMessagesUseCase _getMessagesUseCase;
  final LoadMoreMessagesUseCase _loadMoreMessagesUseCase;

  FutureOr<void> _onMessagesPageInitiated(
    MessagesPageInitiated event,
    Emitter<MessagesState> emit,
  ) async {
    await _getMessages(emit: emit, isInitialLoad: true);
  }

  FutureOr<void> _onMessagesLoadMore(
    MessagesLoadMore event,
    Emitter<MessagesState> emit,
  ) async {
    await _getMessages(emit: emit, isInitialLoad: false);
  }

  Future<void> _getMessages({
    required Emitter<MessagesState> emit,
    required bool isInitialLoad,
  }) async {
    return runBlocCatching(
      action: () async {
        final output = await (isInitialLoad
            ? _getMessagesUseCase.execute(const GetMessagesInput(), true)
            : _loadMoreMessagesUseCase.execute(
                const LoadMoreMessagesInput(),
                false,
              ));
        emit(state.copyWith(messages: output));
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<MessagesState> emit,
  ) async {
    final list = [event.message, ...state.messages.data];
    emit(state.copyWith(messages: state.messages.copyWith(data: list)));
  }
}
