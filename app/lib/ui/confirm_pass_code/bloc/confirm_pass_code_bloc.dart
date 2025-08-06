import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

import '../../../app.dart';
import 'confirm_pass_code.dart';

@Injectable()
class ConfirmPassCodeBloc
    extends BaseBloc<ConfirmPassCodeEvent, ConfirmPassCodeState> {
  ConfirmPassCodeBloc() : super(const ConfirmPassCodeState()) {
    on<ConfirmPassCodePinChanged>(
      _onConfirmPassCodePinChanged,
      transformer: log(),
    );

    on<ConfirmPassCodePinCompleted>(
      _onConfirmPassCodePinCompleted,
      transformer: log(),
    );

    on<ConfirmPassCodePinClear>(
      _onConfirmPassCodePinClear,
      transformer: log(),
    );

    on<EnableBiometric>(
      _onEnableBiometric,
      transformer: log(),
    );
  }

  void _onConfirmPassCodePinChanged(
      ConfirmPassCodePinChanged event, Emitter<ConfirmPassCodeState> emit) {
    emit(state.copyWith(
      confirmPassCode: event.confirmPassCode,
    ));
  }

  FutureOr<void> _onConfirmPassCodePinCompleted(
      ConfirmPassCodePinCompleted event, Emitter<ConfirmPassCodeState> emit) {
    return runBlocCatching(
      action: () async {
        if (event.confirmPassCode == event.passCode) {
          // await navigator.replace(AppRouteInfo.xxx(event.confirmPassCode));
        } else {
          emit(state.copyWith(
            shouldClearPin: true,
          ));
          navigator.showErrorSnackBar(S.current.passcodeError);
        }
      },
      handleLoading: false,
    );
  }

  void _onConfirmPassCodePinClear(
      ConfirmPassCodePinClear event, Emitter<ConfirmPassCodeState> emit) {
    emit(state.copyWith(
      confirmPassCode: '',
      shouldClearPin: false,
    ));
  }

  FutureOr<void> _onEnableBiometric(
      EnableBiometric event, Emitter<ConfirmPassCodeState> emit) async {
    emit(
      state.copyWith(
        enabledBiometric: event.enabledBiometric
            ? await LocalAuthenticationExtUtils.autenticate()
            : false,
      ),
    );
  }
}
