import 'package:equatable/equatable.dart';
import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';

class PaceState extends Equatable {
  final int minutes;
  final int seconds;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const PaceState({
    required this.minutes,
    required this.seconds,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  PaceEntity get entity => PaceEntity(minutes: minutes, seconds: seconds);

  PaceState copyWith({
    int? minutes,
    int? seconds,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return PaceState(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [minutes, seconds, isLoading, errorMessage, isSuccess];
}
