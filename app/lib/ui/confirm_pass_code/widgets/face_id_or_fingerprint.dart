import 'package:flutter/material.dart';

import '../../../app.dart';

class FaceIdOrFingerprint extends StatelessWidget {
  const FaceIdOrFingerprint({
    required this.enabled,
    required this.isIOS,
    super.key,
  });

  final bool enabled;
  final bool isIOS;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: AppColors.current.fingerprintBGColor55,
              borderRadius: BorderRadius.circular(45),
            ),
            child: (isIOS ? Assets.svg.faceId : Assets.svg.fingerprint).svg(),
          )
        : const SizedBox(height: 100);
  }
}
