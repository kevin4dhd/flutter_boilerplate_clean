import 'package:shared/shared.dart';

class PassCodeUtils {
  PassCodeUtils._();

  static bool isValid(String passCode) {
    if (passCode.length != UiConstants.defaultPinLength) {
      return false;
    } else if (_hasRepeatedDigits(passCode)) {
      return false;
    } else if (_isAscendingSequence(passCode)) {
      return false;
    } else if (_isDescendingSequence(passCode)) {
      return false;
    } else if (_isCommonWeakPattern(passCode)) {
      return false;
    }

    return true;
  }

  static bool _hasRepeatedDigits(String pin) {
    return RegExp('^(\\d)\\1{${UiConstants.defaultPinLength - 1}}\$')
        .hasMatch(pin);
  }

  static bool _isAscendingSequence(String pin) {
    for (int i = 1; i < pin.length; i++) {
      final int current = int.parse(pin[i]);
      final int previous = int.parse(pin[i - 1]);
      if (current != (previous + 1) % 10) {
        return false;
      }
    }
    return true;
  }

  static bool _isDescendingSequence(String pin) {
    for (int i = 1; i < pin.length; i++) {
      final int current = int.parse(pin[i]);
      final int previous = int.parse(pin[i - 1]);
      if (current != (previous - 1 + 10) % 10) {
        return false;
      }
    }
    return true;
  }

  static bool _isCommonWeakPattern(String pin) {
    const weakPatterns = [
      '123456',
      '654321',
      '000000',
      '111111',
      '222222',
      '333333',
      '444444',
      '555555',
      '666666',
      '777777',
      '888888',
      '999999'
    ];
    return weakPatterns.contains(pin);
  }

  static bool arePinsMatching(String pin1, String pin2) {
    return pin1 == pin2;
  }
}
