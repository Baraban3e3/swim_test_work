import 'package:equatable/equatable.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';

class UsersState extends Equatable {
  final List<UserEntity> users;
  final List<UserEntity> filteredUsers;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  const UsersState({
    this.users = const [],
    this.filteredUsers = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  UsersState copyWith({
    List<UserEntity>? users,
    List<UserEntity>? filteredUsers,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return UsersState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [users, filteredUsers, isLoading, errorMessage, searchQuery];
}
