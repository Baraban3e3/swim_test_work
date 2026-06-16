import 'package:swim_test/features/pace_selector/data/datasources/pace_remote_data_source.dart';
import 'package:swim_test/features/pace_selector/data/models/pace_request_model.dart';
import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';
import 'package:swim_test/features/pace_selector/domain/repositories/pace_repository.dart';

class PaceRepositoryImpl implements PaceRepository {
  final PaceRemoteDataSource remoteDataSource;

  PaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitPace(PaceEntity pace) async {
    final model = PaceRequestModel(paceSeconds: pace.totalSeconds);
    await remoteDataSource.submitPace(model);
  }
}
