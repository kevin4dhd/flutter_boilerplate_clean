import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'register_user_info.dart';

@Injectable()
class RegisterUserInfoBloc
    extends BaseBloc<RegisterUserInfoEvent, RegisterUserInfoState> {
  RegisterUserInfoBloc() : super(const RegisterUserInfoState()) {
    on<TapOnContinue>(
      _onTapOnContinue,
      transformer: exhaustMap(),
    );
  }

  FutureOr<void> _onTapOnContinue(
      TapOnContinue event, Emitter<RegisterUserInfoState> emit) {
    return runBlocCatching(
      action: () async {},
      handleLoading: false,
    );
  }
}
