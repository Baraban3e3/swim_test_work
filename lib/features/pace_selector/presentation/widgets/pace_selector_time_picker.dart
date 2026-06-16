import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/pace_cubit.dart';
import '../cubit/pace_state.dart';
import 'time_picker_column.dart';

class PaceSelectorTimePicker extends StatelessWidget {
  final PaceState state;
  final PaceCubit cubit;

  const PaceSelectorTimePicker({
    super.key,
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final activeColor = AppColors.getRankColor(state.entity.swimmerLevel);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('pace_selector.your_pace'.tr(), style: theme.labelSmall),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimePickerColumn(
              value: state.minutes,
              onIncrement: () {
                if (state.minutes < 4) {
                  cubit.updateMinutes(state.minutes + 1);
                }
              },
              onDecrement: () {
                if (state.minutes > 0) {
                  cubit.updateMinutes(state.minutes - 1);
                }
              },
              onChanged: (val) {
                if (val >= 0 && val <= 4) {
                  cubit.updateMinutes(val);
                }
              },
              maxValue: 4,
              padWithZero: true,
              activeBackgroundColor: activeColor.withValues(alpha: 0.15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, color: activeColor),
                  const SizedBox(height: 12),
                  Container(width: 8, height: 8, color: activeColor),
                ],
              ),
            ),
            TimePickerColumn(
              value: state.seconds,
              onIncrement: () {
                if (state.seconds == 59) {
                  if (state.minutes < 4) {
                    cubit.updateMinutes(state.minutes + 1);
                    cubit.updateSeconds(0);
                  }
                } else {
                  cubit.updateSeconds(state.seconds + 1);
                }
              },
              onDecrement: () {
                if (state.seconds == 0 && state.minutes > 0) {
                  cubit.updateMinutes(state.minutes - 1);
                  cubit.updateSeconds(59);
                } else if (state.seconds > 0) {
                  cubit.updateSeconds(state.seconds - 1);
                }
              },
              onChanged: (val) {
                if (val >= 0 && val <= 59) {
                  cubit.updateSeconds(val);
                }
              },
              maxValue: 59,
              padWithZero: true,
              activeBackgroundColor: activeColor.withValues(alpha: 0.15),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('pace_selector.min_sec_100m'.tr(), style: theme.labelSmall),
      ],
    );
  }
}
