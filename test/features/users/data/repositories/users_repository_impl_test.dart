import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/core/error/failures.dart';
import 'package:swim_test/features/users/data/datasources/users_remote_data_source.dart';
import 'package:swim_test/features/users/data/models/user_model.dart';
import 'package:swim_test/features/users/data/repositories/users_repository_impl.dart';

class MockUsersRemoteDataSource extends Mock implements UsersRemoteDataSource {}

void main() {
  late UsersRepositoryImpl repository;
  late MockUsersRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockUsersRemoteDataSource();
    repository = UsersRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getUsers', () {
    const tUserModelList = [
      UserModel(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        phone: '1-770-736-8031 x56442',
        website: 'hildegard.org',
        companyName: 'Romaguera-Crona',
      )
    ];

    test('should return remote data when the call to remote data source is successful', () async {
      when(() => mockRemoteDataSource.getUsers())
          .thenAnswer((_) async => tUserModelList);

      final result = await repository.getUsers();

      verify(() => mockRemoteDataSource.getUsers());
      expect(result, equals(tUserModelList));
    });

    test('should throw ServerFailure when the call to remote data source is unsuccessful', () async {
      when(() => mockRemoteDataSource.getUsers())
          .thenThrow(ServerException('Error'));

      final call = repository.getUsers;

      expect(() => call(), throwsA(isA<ServerFailure>()));
    });
  });
}
