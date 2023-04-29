import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/routing/route_guards.dart';
import 'package:testador/core/screens/landing_screen.dart';
import 'package:testador/features/authentication/presentation/screens/registration_screen.dart';
import 'package:testador/features/testing/presentation/screens/home_screen.dart';
import 'package:testador/features/testing/presentation/screens/test_screen.dart';
export 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth',
      name: 'AuthenticationFlowRoute',
      page: AuthenticationFlow,
      children: [AutoRoute(page: RegistrationScreen, path: 'sign-up')],
    ),
    AutoRoute(
      path: '/unprotected',
      name: 'UnprotectedFlowRoute',
      page: UnprotectedFlow,
      children: [
        AutoRoute(
          initial: true,
          path: '',
          page: LandingScreen,
        ),
      ],
    ),
    AutoRoute(
      path: '/protected',
      name: 'ProtectedFlowRoute',
      page: ProtectedFlow,
      initial: true,
      children: [
        AutoRoute(
          path: 'test-admin/:id',
          page: TestAdminScreen,
        ),
        AutoRoute(initial: true, page: HomeScreen, path: ''),
      ],
    ),
    AutoRoute(
      path: 'loading',
      page: LoadingScreen,
    ),
  ],
)
class $AppRouter {}

class AuthenticationFlow extends StatelessWidget {
  const AuthenticationFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

class ProtectedFlow extends StatelessWidget {
  const ProtectedFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

class UnprotectedFlow extends StatelessWidget {
  const UnprotectedFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
