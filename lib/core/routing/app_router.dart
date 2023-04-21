import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/screens/landing_screen.dart';
import 'package:testador/features/authentication/presentation/screens/registration_screen.dart';
export 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: 'HomeRoute',
      children: [
        AutoRoute(page: RegistrationScreen, path: 'sign-up'),
        AutoRoute(
          path: '',
          page: LandingScreen,
        ),
      ],
      page: HomeWrapper,
    ),
    AutoRoute(
      page: LoadingScreen,
    ),
  ],
)
class $AppRouter {}

class AuthenticaitonFlow extends StatelessWidget {
  const AuthenticaitonFlow({super.key});

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

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
