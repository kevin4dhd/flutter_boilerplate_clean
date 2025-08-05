import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pincode_input_fields/pincode_input_fields.dart';
import 'package:pinput/pinput.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class AppPinput extends StatelessWidget {
  const AppPinput({
    super.key,
    this.defaultPinTheme,
    this.pinLength,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
  });

  final PinTheme? defaultPinTheme;
  final int? pinLength;
  final PincodeInputFieldsController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: defaultPinTheme ?? AppPinStyles.getDefaultTheme(),
      length: pinLength ?? UiConstants.defaultPinLength,
      keyboardType: TextInputType.phone,
      controller: controller,
      focusNode: focusNode,
      autofocus: true,
      obscureText: true,
      useNativeKeyboard: true,
      toolbarEnabled: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      contextMenuBuilder: (_, __) => const SizedBox.shrink(),
      onLongPress: () {},
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}
