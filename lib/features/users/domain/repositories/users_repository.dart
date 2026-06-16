import 'package:swim_test/features/users/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<List<UserEntity>> getUsers();
}
