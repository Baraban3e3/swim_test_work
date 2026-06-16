import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_test/core/usecases/usecase.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/domain/usecases/get_users_usecase.dart';
import 'package:swim_test/features/users/presentation/cubit/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUseCase _getUsersUseCase;

  UsersCubit(this._getUsersUseCase) : super(const UsersState()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final users = await _getUsersUseCase(NoParams());
      emit(state.copyWith(
        isLoading: false,
        users: users,
        filteredUsers: _filterUsers(users, state.searchQuery),
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void searchUsers(String query) {
    emit(state.copyWith(
      searchQuery: query,
      filteredUsers: _filterUsers(state.users, query),
    ));
  }

  List<UserEntity> _filterUsers(List<UserEntity> users, String query) {
    if (query.isEmpty) return users;
    final lowerQuery = query.toLowerCase();
    return users.where((u) => 
      u.name.toLowerCase().contains(lowerQuery) ||
      u.username.toLowerCase().contains(lowerQuery) ||
      u.email.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}
