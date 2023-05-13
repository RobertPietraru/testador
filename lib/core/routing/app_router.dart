import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/routing/route_guards.dart';
import 'package:testador/core/screens/landing_screen.dart';
import 'package:testador/features/authentication/presentation/screens/login/login_screen.dart';
import 'package:testador/features/authentication/presentation/screens/registration/registration_screen.dart';
import 'package:testador/features/test/presentation/screens/test_list/test_list_screen.dart';
import 'package:testador/features/test/presentation/screens/test_editor/test_editor_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: App, children: [
      AutoRoute(
        path: 'auth',
        name: 'AuthenticationFlowRoute',
        page: AuthenticationFlow,
        children: [
          AutoRoute(initial: true, page: RegistrationScreen, path: 'signup'),
          AutoRoute(page: LoginScreen, path: 'loginin'),
        ],
      ),
      AutoRoute(
        path: '',
        name: 'UnprotectedFlowRoute',
        page: UnprotectedFlow,
        initial: true,
        children: [
          AutoRoute(
            initial: true,
            path: '',
            page: LandingScreen,
          ),
        ],
      ),
      AutoRoute(
        path: 'protected',
        name: 'ProtectedFlowRoute',
        page: ProtectedFlow,
        guards: [AuthGuard],
        children: [
          AutoRoute(
            path: 'quiz-admin/:id',
            page: QuizEditorScreen,
          ),
          AutoRoute(initial: true, page: QuizListScreen, path: ''),
        ],
      ),
    ]),
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

class App extends StatelessWidget {
  const App({super.key});

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
