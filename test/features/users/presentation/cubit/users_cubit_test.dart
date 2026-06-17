import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swim_test/core/error/failures.dart';
import 'package:swim_test/core/usecases/usecase.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/domain/usecases/get_users_usecase.dart';
import 'package:swim_test/features/users/presentation/cubit/users_cubit.dart';
import 'package:swim_test/features/users/presentation/cubit/users_state.dart';

class MockGetUsersUseCase extends Mock implements GetUsersUseCase {}
class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockGetUsersUseCase mockGetUsersUseCase;

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    mockGetUsersUseCase = MockGetUsersUseCase();
    when(() => mockGetUsersUseCase(any())).thenAnswer((_) async => []);
  });

  group('UsersCubit', () {
    const tUserList = [
      UserEntity(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        phone: '1-770-736-8031 x56442',
        website: 'hildegard.org',
        companyName: 'Romaguera-Crona',
      ),
      UserEntity(
        id: 2,
        name: 'Ervin Howell',
        username: 'Antonette',
        email: 'Shanna@melissa.tv',
        phone: '010-692-6593 x09125',
        website: 'anastasia.net',
        companyName: 'Deckow-Crist',
      ),
    ];

    group('fetchUsers', () {
      test('should emit Loaded state when successful', () async {
        when(() => mockGetUsersUseCase(any())).thenAnswer((_) async => tUserList);
        final cubit = UsersCubit(mockGetUsersUseCase);
        
        await Future.delayed(Duration.zero);
        
        expect(cubit.state, const UsersState(isLoading: false, users: tUserList, filteredUsers: tUserList));
      });

      test('should emit Error state when getting data fails', () async {
        when(() => mockGetUsersUseCase(any())).thenThrow(ServerFailure('Server Error'));
        final cubit = UsersCubit(mockGetUsersUseCase);
        
        await Future.delayed(Duration.zero);
        
        expect(cubit.state, const UsersState(isLoading: false, errorMessage: 'ServerFailure(Server Error)'));
      });
    });

    group('searchUsers', () {
      blocTest<UsersCubit, UsersState>(
        'should filter users by name correctly',
        build: () {
          when(() => mockGetUsersUseCase(any()))
              .thenAnswer((_) async => tUserList);
          return UsersCubit(mockGetUsersUseCase);
        },
        seed: () => const UsersState(
          isLoading: false,
          users: tUserList,
          filteredUsers: tUserList,
        ),
        act: (cubit) => cubit.searchUsers('Leanne'),
        expect: () => [
          UsersState(
            isLoading: false,
            users: tUserList,
            filteredUsers: [tUserList[0]],
            searchQuery: 'Leanne',
          ),
        ],
      );

      blocTest<UsersCubit, UsersState>(
        'should filter users by email correctly',
        build: () {
          when(() => mockGetUsersUseCase(any()))
              .thenAnswer((_) async => tUserList);
          return UsersCubit(mockGetUsersUseCase);
        },
        seed: () => const UsersState(
          isLoading: false,
          users: tUserList,
          filteredUsers: tUserList,
        ),
        act: (cubit) => cubit.searchUsers('shanna'),
        expect: () => [
          UsersState(
            isLoading: false,
            users: tUserList,
            filteredUsers: [tUserList[1]],
            searchQuery: 'shanna',
          ),
        ],
      );
    });
  });
}
