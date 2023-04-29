import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/components/theme/app_theme.dart';
import '../core/components/theme/app_theme_data.dart';
import '../core/routing/app_router.gr.dart';
import '../features/authentication/presentation/auth_bloc/auth_bloc.dart';
import '../features/authentication/presentation/widgets/auth_bloc_wrapper.dart';
import '../injection.dart';

void mainDevelopment() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();

  runApp(const AuthBlocWidget(child: MyApp()));
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
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
//        authGuard: AuthGuard(isAuthenticated: state is AuthAuthenticatedState)

    return AppTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp.router(
        routerDelegate: AutoRouterDelegate.declarative(
          appRouter,
          routes: (_) {
            if (state.userEntity == null) {
              return [const UnprotectedFlowRoute()];
            } else {
              return [const ProtectedFlowRoute()];
            }
          },
        ),
        routeInformationParser: appRouter.defaultRouteParser(),
        theme: _lightTheme.materialThemeData(context),
        darkTheme: _darkTheme.materialThemeData(context),
        // themeMode: darkModePreference?.toThemeMode(),
        themeMode: ThemeMode.light,
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', 'BR'),
          Locale('ro', 'RO'),
        ],
      ),
    );
  }
}
