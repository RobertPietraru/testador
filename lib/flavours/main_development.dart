import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:testador/features/test/data/dtos/test/question_dto.dart';
import 'package:testador/features/test/data/dtos/test/test_dto.dart';

import '../core/components/theme/app_theme.dart';
import '../core/components/theme/app_theme_data.dart';
import '../core/routing/app_router.gr.dart';
import '../core/routing/route_guards.dart';
import '../features/authentication/presentation/auth_bloc/auth_bloc.dart';
import '../features/authentication/presentation/widgets/auth_bloc_wrapper.dart';
import '../injection.dart';

void mainDevelopment() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TestDtoAdapter());
  Hive.registerAdapter(QuestionDtoAdapter());
  Hive.registerAdapter(MultipleChoiceOptionDtoAdapter());
  Hive.registerAdapter(QuestionTypeDtoAdapter());
  await Hive.openBox<TestDto>(TestDto.hiveBoxName);
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
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      authGuard: AuthGuard(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return AppTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerDelegate:
              AutoRouterDelegate.declarative(_appRouter, routes: (_) {
            if (authBloc is AuthUninitialisedState) {
              return [LoadingRoute()];
            }
            return [App()];
          }),
          routeInformationParser: _appRouter.defaultRouteParser(),
          theme: _lightTheme.materialThemeData(context),
          darkTheme: _darkTheme.materialThemeData(context),
          themeMode: ThemeMode.light,
          supportedLocales: const [
            Locale('en', ''),
            Locale('pt', 'BR'),
            Locale('ro', 'RO'),
          ],
        );
      }),
    );
  }
}
