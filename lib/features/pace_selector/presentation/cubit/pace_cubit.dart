import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_test/features/pace_selector/domain/usecases/submit_pace_usecase.dart';
import 'package:swim_test/features/pace_selector/presentation/cubit/pace_state.dart';

class PaceCubit extends Cubit<PaceState> {
  final SubmitPaceUseCase _submitPaceUseCase;

  PaceCubit(this._submitPaceUseCase) : super(const PaceState(minutes: 1, seconds: 30));

  void updateMinutes(int minutes) {
    if (minutes < 0 || minutes > 4) return;
    int newSeconds = state.seconds;
    if (minutes == 4) {
      newSeconds = 0;
    }
    emit(state.copyWith(minutes: minutes, seconds: newSeconds));
  }

  void updateSeconds(int seconds) {
    if (seconds < 0 || seconds > 59) return;
    if (state.minutes == 4 && seconds > 0) return;
    emit(state.copyWith(seconds: seconds));
  }

  void updateFromTotalSeconds(int totalSeconds) {
    final mins = totalSeconds ~/ 60;
    final secs = totalSeconds % 60;
    emit(state.copyWith(minutes: mins, seconds: secs));
  }

  Future<void> submitPace() async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      await _submitPaceUseCase(state.entity);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
