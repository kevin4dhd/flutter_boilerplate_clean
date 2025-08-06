import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

import '../../../app.dart';
import 'pass_code.dart';

@Injectable()
class PassCodeBloc extends BaseBloc<PassCodeEvent, PassCodeState> {
  PassCodeBloc() : super(const PassCodeState()) {
    on<PassCodePinChanged>(
      _onPassCodePinChanged,
      transformer: log(),
    );

    on<PassCodePinCompleted>(
      _onPassCodePinCompleted,
      transformer: log(),
    );

    on<PassCodePinClear>(
      _onPassCodePinClear,
      transformer: log(),
    );
  }

  void _onPassCodePinChanged(
      PassCodePinChanged event, Emitter<PassCodeState> emit) {
    emit(state.copyWith(
      passCode: event.passCode,
    ));
  }

  FutureOr<void> _onPassCodePinCompleted(
      PassCodePinCompleted event, Emitter<PassCodeState> emit) {
    return runBlocCatching(
      action: () async {
        if (PassCodeUtils.isValid(event.passCode)) {
          await navigator.replace(AppRouteInfo.confirmPassCode(event.passCode));
        } else {
          emit(state.copyWith(
            shouldClearPin: true,
          ));
          navigator.showErrorSnackBar(S.current.insecurePass);
        }
      },
      handleLoading: false,
    );
  }

  void _onPassCodePinClear(
      PassCodePinClear event, Emitter<PassCodeState> emit) {
    emit(state.copyWith(
      passCode: '',
      shouldClearPin: false,
    ));
  }
}
