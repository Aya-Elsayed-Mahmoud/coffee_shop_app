import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class WelcomeText extends StatelessWidget {
  final String username;

  const WelcomeText({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        "Hi $username, enjoy your coffee!",
        style: AppTextStyles.headLine.copyWith(color: AppColors.white),
      ),
    );
  }
}
