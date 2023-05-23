import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/features/authentication/presentation/screens/login/login_screen.dart';
import 'package:testador/features/authentication/presentation/screens/registration/registration_screen.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_list/quiz_list_screen.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_editor/quiz_editor_screen.dart';
import 'package:testador/features/quiz/presentation/screens/quiz_screen.dart';

import '../../features/quiz/presentation/session/session_manager_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
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
      path: 'protected',
      name: 'ProtectedFlowRoute',
      page: ProtectedFlow,
      children: [
        AutoRoute(
          path: 'quiz-admin/:id',
          page: QuizEditorScreen,
        ),
        AutoRoute(
          path: 'quiz/:id',
          page: QuizScreen,
        ),
        AutoRoute(
          path: 'session-create/:id',
          page: QuizSessionManagercreen,
        ),
        AutoRoute(initial: true, page: QuizListScreen, path: ''),
      ],
    ),
    AutoRoute(path: 'loading', page: LoadingScreen),
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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
