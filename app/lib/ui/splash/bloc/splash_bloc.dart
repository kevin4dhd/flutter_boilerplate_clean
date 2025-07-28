import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import 'splash.dart';

@Injectable()
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(this._isLoggedInUseCase) : super(const SplashState()) {
    on<SplashPageInitiated>(
      _onSplashPageInitiated,
      transformer: log(),
    );
  }

  final IsLoggedInUseCase _isLoggedInUseCase;

  FutureOr<void> _onSplashPageInitiated(
    SplashPageInitiated event,
    Emitter<SplashState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await Future<void>.delayed(DurationConstants.defaultSplashDuration);
        final isLoggedIn =
            _isLoggedInUseCase.execute(const IsLoggedInInput()).isLoggedIn;
        await navigator.replace(
          isLoggedIn ? const AppRouteInfo.main() : const AppRouteInfo.login(),
        );
      },
      handleError: false,
      handleLoading: false,
    );
  }
}
