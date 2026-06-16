import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_test/core/theme/app_theme.dart';
import 'package:swim_test/features/pace_selector/presentation/pages/pace_selector_screen.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';
import 'package:swim_test/features/users/presentation/pages/user_detail_screen.dart';
import 'package:swim_test/features/users/presentation/pages/users_list_screen.dart';
import 'package:swim_test/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uk')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Swim Test',
      theme: AppTheme.darkTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

final GoRouter _router = GoRouter(
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
