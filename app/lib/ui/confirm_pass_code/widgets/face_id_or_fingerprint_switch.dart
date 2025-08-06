import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../../resource/styles/app_text_styles.dart';

class FaceIdOrFingerprintSwitch extends StatelessWidget {
  const FaceIdOrFingerprintSwitch({
    required this.isIOS,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool isIOS;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50.0,
          height: 30.0,
          child: Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.all(Colors.white),
            activeTrackColor: Colors.green,
            inactiveTrackColor: const Color(0xFF242438),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            padding: const EdgeInsets.all(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          isIOS ? S.current.enableFaceId : S.current.enableFingerprint,
          style: AppTextStyles.s16w400Popular(),
        ),
      ],
    );
  }
}
