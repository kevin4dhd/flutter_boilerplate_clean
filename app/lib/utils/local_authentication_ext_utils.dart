import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

class LocalAuthenticationExtUtils extends LocalAuthenticationUtils {
  LocalAuthenticationExtUtils._();

  static Future<bool> autenticate() async {
    try {
      final s = S.current;
      return await LocalAuthentication().authenticate(
        authMessages: [
          AndroidAuthMessages(
            signInTitle: s.signInTitle,
            cancelButton: s.cancel,
            goToSettingsButton: s.goToSettingsButton,
            goToSettingsDescription: s.goToSettingsDescription,
            biometricHint: s.biometricHint,
            biometricNotRecognized: s.biometricNotRecognized,
            biometricRequiredTitle: s.biometricRequiredTitle,
            deviceCredentialsRequiredTitle: s.deviceCredentialsRequiredTitle,
            deviceCredentialsSetupDescription:
                s.deviceCredentialsSetupDescription,
          )
        ],
        localizedReason: s.localizedReason,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (error) {
      Log.e(error);
    }

    return false;
  }
}
