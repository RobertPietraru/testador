import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/screens/landing_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: 'HomeRoute',
      children: [
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
