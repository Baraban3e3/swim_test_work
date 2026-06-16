import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';

abstract class PaceRepository {
  Future<void> submitPace(PaceEntity pace);
}
