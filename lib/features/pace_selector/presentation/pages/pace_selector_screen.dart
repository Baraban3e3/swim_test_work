import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../injection_container.dart';
import '../cubit/pace_cubit.dart';
import '../cubit/pace_state.dart';

import '../widgets/pace_selector_header.dart';
import '../widgets/pace_selector_time_picker.dart';
import '../widgets/pace_selector_bottom_section.dart';

class PaceSelectorScreen extends StatelessWidget {
  const PaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaceCubit>(),
      child: const PaceSelectorView(),
    );
  }
}

class PaceSelectorView extends StatelessWidget {
  const PaceSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<PaceCubit, PaceState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.isSuccess != current.isSuccess,
        listener: _handleStateChanges,
        builder: (context, state) {
          final cubit = context.read<PaceCubit>();
          final totalSeconds = state.minutes * 60 + state.seconds;
          final swimmerLevel = state.entity.swimmerLevel;
          final rankColor = AppColors.getRankColor(swimmerLevel);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const PaceSelectorHeader(),
                        const Spacer(flex: 3),
                        PaceSelectorTimePicker(state: state, cubit: cubit),
                        const Spacer(flex: 2),
                        PaceSelectorBottomSection(
                          state: state,
                          cubit: cubit,
                          totalSeconds: totalSeconds,
                          swimmerLevel: swimmerLevel,
                          rankColor: rankColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, PaceState state) {
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    }
    if (state.isSuccess) {
      context.push('/users');
    }
  }
}
