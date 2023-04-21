import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/routing/app_router.gr.dart';

import 'core/components/theme/app_theme.dart';
import 'core/components/theme/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _lightTheme = LightAppThemeData();
  final _darkTheme = DarkAppThemeData();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp.router(
        routerDelegate: AutoRouterDelegate.declarative(
          _appRouter,
          routes: (_) {
            return [const HomeRoute()];
          },
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: _lightTheme.materialThemeData(context),
        darkTheme: _darkTheme.materialThemeData(context),
        // themeMode: darkModePreference?.toThemeMode(),
        themeMode: ThemeMode.dark,
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', 'BR'),
          Locale('ro', 'RO'),
        ],
      ),
    );
  }
}
