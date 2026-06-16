import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaceSelectorHeader extends StatelessWidget {
  const PaceSelectorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('pace_selector.header_title'.tr(), style: theme.headlineLarge),
          const SizedBox(height: 16),
          Text(
            'pace_selector.header_subtitle'.tr(),
            style: theme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
