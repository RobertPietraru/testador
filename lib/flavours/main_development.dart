import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/authentication/domain/auth_domain.dart';

import '../core/components/theme/app_theme.dart';
import '../core/components/theme/app_theme_data.dart';
import '../core/routing/app_router.gr.dart';
import '../core/routing/route_guards.dart';
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
  AppRouter? _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      authLoadingGuard: AuthLoadingGuard(
        context: context,
        authBloc: context.read<AuthBloc>(),
      ),
      authGuard: AuthGuard(
        context: context,
        authBloc: context.read<AuthBloc>(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp.router(
        routerDelegate: _appRouter!.delegate(),
        routeInformationParser: _appRouter!.defaultRouteParser(),
        theme: _lightTheme.materialThemeData(context),
        darkTheme: _darkTheme.materialThemeData(context),
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
