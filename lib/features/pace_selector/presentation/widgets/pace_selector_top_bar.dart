import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PaceSelectorTopBar extends StatelessWidget {
  const PaceSelectorTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.divider,
        ),
        child: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary, size: 24),
          onPressed: () {},
        ),
      ),
    );
  }
}
