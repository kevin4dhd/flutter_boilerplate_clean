import 'package:local_auth/local_auth.dart';

class LocalAuthenticationUtils {
  static Future<bool> canCheckBiometrics() async {
    final auth = LocalAuthentication();
    return await auth.canCheckBiometrics && await auth.isDeviceSupported();
  }
}
