import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_test/features/users/presentation/cubit/users_cubit.dart';
import 'package:swim_test/features/users/presentation/cubit/users_state.dart';
import 'package:swim_test/injection_container.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UsersCubit>(),
      child: const UsersListView(),
    );
  }
}

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users_list.title'.tr()),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          final cubit = context.read<UsersCubit>();
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: cubit.searchUsers,
                  decoration: InputDecoration(
                    hintText: 'Search by name, email, or username...',
                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: state.isLoading && state.users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : state.errorMessage != null && state.users.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.errorMessage!, style: const TextStyle(color: Colors.redAccent)),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: cubit.fetchUsers,
                                  child: Text('users_list.retry'.tr()),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: cubit.fetchUsers,
                            child: state.filteredUsers.isEmpty
                                ? Center(child: Text('users_list.no_users'.tr()))
                                : ListView.builder(
                                    itemCount: state.filteredUsers.length,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    itemBuilder: (context, index) {
                                      final user = state.filteredUsers[index];
                                      return Card(
                                        color: const Color(0xFF2C2C2E),
                                        margin: const EdgeInsets.only(bottom: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.all(16),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                                            child: Text(
                                              user.name.substring(0, 1),
                                              style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(Icons.email, size: 14, color: Colors.white54),
                                                  const SizedBox(width: 4),
                                                  Expanded(child: Text(user.email, style: const TextStyle(color: Colors.white54))),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  const Icon(Icons.phone, size: 14, color: Colors.white54),
                                                  const SizedBox(width: 4),
                                                  Expanded(child: Text(user.phone, style: const TextStyle(color: Colors.white54))),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            context.push('/users/${user.id}', extra: user);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
