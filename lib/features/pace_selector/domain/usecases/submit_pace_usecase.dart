import 'package:swim_test/core/usecases/usecase.dart';
import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';
import 'package:swim_test/features/pace_selector/domain/repositories/pace_repository.dart';

class SubmitPaceUseCase implements UseCase<void, PaceEntity> {
  final PaceRepository repository;

  SubmitPaceUseCase(this.repository);

  @override
  Future<void> call(PaceEntity params) {
    return repository.submitPace(params);
  }
}
