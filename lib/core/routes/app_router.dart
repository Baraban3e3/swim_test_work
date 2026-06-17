import 'package:go_router/go_router.dart';
import 'package:swim_test/features/pace_selector/presentation/pages/pace_selector_screen.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/presentation/pages/user_detail_screen.dart';
import 'package:swim_test/features/users/presentation/pages/users_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PaceSelectorScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final user = state.extra as UserEntity;
            return UserDetailScreen(user: user);
          },
        ),
      ],
    ),
  ],
);
