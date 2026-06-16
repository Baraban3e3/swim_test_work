class PaceRequestModel {
  final int paceSeconds;

  PaceRequestModel({required this.paceSeconds});

  Map<String, dynamic> toJson() {
    return {
      'pace_seconds': paceSeconds,
    };
  }
}
