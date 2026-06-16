import 'package:swim_test/features/users/data/datasources/users_remote_data_source.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/domain/repositories/users_repository.dart';

import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/core/error/failures.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      return await remoteDataSource.getUsers();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
