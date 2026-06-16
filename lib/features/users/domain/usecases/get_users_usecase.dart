import 'package:swim_test/core/usecases/usecase.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/domain/repositories/users_repository.dart';

class GetUsersUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<List<UserEntity>> call(NoParams params) {
    return repository.getUsers();
  }
}
