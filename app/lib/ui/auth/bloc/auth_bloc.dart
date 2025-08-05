import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'auth.dart';

@Injectable()
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<ClickOnCreate>(
      _onClickOnCreate,
      transformer: log(),
    );

    on<ClickOnImport>(
      _onClickOnImport,
      transformer: log(),
    );
  }

  FutureOr<void> _onClickOnCreate(
      ClickOnCreate event, Emitter<AuthState> emit) {
    return runBlocCatching(
      action: () async => navigator.push(const AppRouteInfo.passCode()),
      handleLoading: false,
    );
  }

  FutureOr<void> _onClickOnImport(
      ClickOnImport event, Emitter<AuthState> emit) {
    return runBlocCatching(
      action: () async {
        // Navigate to import wallet flow - implementation pending
      },
      handleLoading: false,
    );
  }
}
