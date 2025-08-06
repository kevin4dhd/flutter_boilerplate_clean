import 'package:injectable/injectable.dart';

import '../../shared.dart';

@LazySingleton()
class DeviceInfo {
  bool canCheckBiometrics = false;

  Future<void> init() async {
    canCheckBiometrics = await LocalAuthenticationUtils.canCheckBiometrics();
    Log.d(canCheckBiometrics, name: 'CAN_CHECK_BIOMETRICS');
  }
}
