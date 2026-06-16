import 'package:equatable/equatable.dart';

class PaceEntity extends Equatable {
  final int minutes;
  final int seconds;

  const PaceEntity({
    required this.minutes,
    required this.seconds,
  });

  int get totalSeconds => minutes * 60 + seconds;

  String get swimmerLevel {
    final total = totalSeconds;
    if (total <= 70) return 'Elite';
    if (total <= 90) return 'Advanced';
    if (total <= 150) return 'Intermediate';
    return 'Beginner';
  }

  @override
  List<Object> get props => [minutes, seconds];
}
