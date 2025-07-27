import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'home.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getUsersUseCase,
    this._getMessagesUseCase,
    this._loadMoreMessagesUseCase,
  ) : super(HomeState()) {
    on<HomePageInitiated>(
      _onHomePageInitiated,
      transformer: log(),
    );

    on<UserLoadMore>(
      _onUserLoadMore,
      transformer: log(),
    );

    on<HomePageRefreshed>(
      _onHomePageRefreshed,
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
  final GetUsersUseCase _getUsersUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final LoadMoreMessagesUseCase _loadMoreMessagesUseCase;

  FutureOr<void> _onHomePageInitiated(HomePageInitiated event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isShimmerLoading: false)),
    );

    await _getMessages(
      emit: emit,
      isInitialLoad: true,
    );
  }

  FutureOr<void> _onUserLoadMore(UserLoadMore event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onMessagesLoadMore(MessagesLoadMore event, Emitter<HomeState> emit) async {
    await _getMessages(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onHomePageRefreshed(HomePageRefreshed event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  Future<void> _getUsers({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getUsersUseCase.execute(const GetUsersInput(), isInitialLoad);
        emit(state.copyWith(users: output));
      },
      doOnError: (e) async {
        emit(state.copyWith(loadUsersException: e));
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      maxRetries: 3,
    );
  }

  Future<void> _getMessages({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
  }) async {
    return runBlocCatching(
      action: () async {
        final output = await (isInitialLoad
            ? _getMessagesUseCase.execute(const GetMessagesInput(), true)
            : _loadMoreMessagesUseCase.execute(const LoadMoreMessagesInput(), false));
        emit(state.copyWith(messages: output));
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<HomeState> emit,
  ) async {
    final list = [event.message, ...state.messages.data];
    emit(state.copyWith(messages: state.messages.copyWith(data: list)));
  }
}
