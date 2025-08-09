import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'app_route_info.freezed.dart';

/// page
@freezed
class AppRouteInfo with _$AppRouteInfo {
  const factory AppRouteInfo.splash() = _Splash;
  const factory AppRouteInfo.welcome() = _Welcome;
  const factory AppRouteInfo.auth() = _Auth;
  const factory AppRouteInfo.passCode() = _PassCode;
  const factory AppRouteInfo.confirmPassCode(String passCode) =
      _ConfirmPassCode;
  const factory AppRouteInfo.secretPhraseCreation(
      PassCodeSettings passCodeSettings) = _SecretPhraseCreation;
  const factory AppRouteInfo.secretPhraseVerification(
      SecretPhraseVerificationParams params) = _SecretPhraseVerification;
  const factory AppRouteInfo.registerUserInfo() = _RegisterUserInfo;
  const factory AppRouteInfo.login() = _Login;
  const factory AppRouteInfo.main() = _Main;
  const factory AppRouteInfo.itemDetail(User user) = _UserDetail;
}
