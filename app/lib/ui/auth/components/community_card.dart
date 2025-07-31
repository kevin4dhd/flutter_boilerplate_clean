import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    required this.image,
    required this.name,
    required this.country,
    required this.members,
    super.key,
  });

  final AssetGenImage image;
  final String name;
  final String country;
  final String members;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: image.image(),
          ),
        ),
        const SizedBox(width: UiConstants.commonPA),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.s14BoldPrimary(),
                    ),
                  ),
                  Text(
                    members.toString(),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.s12BoldIcons(),
                  ),
                ],
              ),
              Text(
                country,
                style: AppTextStyles.s14w400Popular(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
