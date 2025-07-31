import 'dart:async';

// import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import 'welcome.dart';

@Injectable()
class WelcomeBloc extends BaseBloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<ClickOnContinue>(
      _onClickOnContinue,
      transformer: log(),
    );

    on<ClickOnTerms>(
      _onClickOnTerms,
      transformer: log(),
    );

    on<ClickOnPrivacity>(
      _onClickOnPrivacity,
      transformer: log(),
    );
  }

  FutureOr<void> _onClickOnContinue(
      ClickOnContinue event, Emitter<WelcomeState> emit) {
    return runBlocCatching(
      action: () async {
        // await navigator.replace(const AppRouteInfo.login());
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onClickOnTerms(
      ClickOnTerms event, Emitter<WelcomeState> emit) {
    return runBlocCatching(
      action: () async =>
          await IntentUtils.openBrowserURL(url: UrlConstants.termUrl),
      handleLoading: false,
    );
  }

  FutureOr<void> _onClickOnPrivacity(
      ClickOnPrivacity event, Emitter<WelcomeState> emit) {
    return runBlocCatching(
      action: () async =>
          await IntentUtils.openBrowserURL(url: UrlConstants.privacy),
      handleLoading: false,
    );
  }
}
