import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/pace_cubit.dart';
import '../cubit/pace_state.dart';
import 'pace_slider.dart';

class PaceSelectorBottomSection extends StatelessWidget {
  final PaceState state;
  final PaceCubit cubit;
  final int totalSeconds;
  final String swimmerLevel;
  final Color rankColor;

  const PaceSelectorBottomSection({
    super.key,
    required this.state,
    required this.cubit,
    required this.totalSeconds,
    required this.swimmerLevel,
    required this.rankColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text('pace_selector.that_puts_you_at'.tr(), style: theme.labelSmall),
          const SizedBox(height: 8),
          Text(
            'pace_selector.levels.$swimmerLevel'.tr(),
            style: theme.headlineLarge?.copyWith(color: rankColor, fontSize: 24),
          ),
          const SizedBox(height: 32),
          
          _buildRanksRow(context, swimmerLevel),
          const SizedBox(height: 16),
          
          PaceSlider(
            totalSeconds: totalSeconds,
            onChanged: (val) => cubit.updateFromTotalSeconds(val),
            activeColor: rankColor,
          ),
          
          const SizedBox(height: 32),
          _buildContinueButton(state, cubit, swimmerLevel, rankColor),
          const SizedBox(height: 16),
          _buildSkipTextButton(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRanksRow(BuildContext context, String currentLevel) {
    const levels = ['Elite', 'Advanced', 'Intermediate', 'Beginner'];
    
    return Row(
      children: levels.map((level) {
        final isActive = currentLevel == level;
        return Expanded(
          child: Text(
            'pace_selector.levels.$level'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContinueButton(PaceState state, PaceCubit cubit, String swimmerLevel, Color rankColor) {
    final isLightColor = swimmerLevel == 'Beginner';
    final textColor = isLightColor ? AppColors.background : AppColors.textPrimary;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: rankColor,
          foregroundColor: textColor,
        ),
        onPressed: state.isLoading ? null : () => cubit.submitPace(),
        child: state.isLoading
            ? const CircularProgressIndicator(color: AppColors.textPrimary)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('pace_selector.continue_btn'.tr(), style: TextStyle(color: textColor)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20, color: textColor),
                ],
              ),
      ),
    );
  }

  Widget _buildSkipTextButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.push('/users'),
      child: Text(
        'pace_selector.skip_btn'.tr(),
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textMuted,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textMuted,
        ),
      ),
    );
  }
}
