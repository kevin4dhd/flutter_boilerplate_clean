import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

@LazySingleton(as: BaseRouteInfoMapper)
class AppRouteInfoMapper extends BaseRouteInfoMapper {
  @override
  PageRouteInfo map(AppRouteInfo appRouteInfo) {
    return appRouteInfo.when(
      splash: () => const SplashRoute(),
      welcome: () => const WelcomeRoute(),
      auth: () => const AuthRoute(),
      passCode: () => const PassCodeRoute(),
      confirmPassCode: (passCode) => ConfirmPassCodeRoute(passCode: passCode),
      login: () => const LoginRoute(),
      main: () => const MainRoute(),
      itemDetail: (user) => ItemDetailRoute(user: user),
    );
  }
}
