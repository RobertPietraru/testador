// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../features/authentication/presentation/screens/login/login_screen.dart'
    as _i3;
import '../../features/authentication/presentation/screens/registration/registration_screen.dart'
    as _i2;
import '../../features/quiz/domain/entities/draft_entity.dart' as _i12;
import '../../features/quiz/domain/entities/quiz_entity.dart' as _i10;
import '../../features/quiz/presentation/screens/quiz_editor/quiz_editor_screen.dart'
    as _i5;
import '../../features/quiz/presentation/screens/quiz_list/cubit/quiz_list_cubit.dart'
    as _i11;
import '../../features/quiz/presentation/screens/quiz_list/quiz_list_screen.dart'
    as _i6;
import '../screens/landing_screen.dart' as _i4;
import 'app_router.dart' as _i1;
import 'route_guards.dart' as _i9;

class AppRouter extends _i7.RootStackRouter {
  AppRouter({
    _i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i9.AuthGuard authGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    App.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.App(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
      );
    },
    AuthenticationFlowRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationFlow(),
      );
    },
    UnprotectedFlowRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.UnprotectedFlow(),
      );
    },
    ProtectedFlowRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProtectedFlow(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegistrationScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LandingScreen(),
      );
    },
    QuizEditorRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<QuizEditorRouteArgs>(
          orElse: () =>
              QuizEditorRouteArgs(quizId: pathParams.getString('id')));
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.QuizEditorScreen(
          key: args.key,
          quizId: args.quizId,
          quiz: args.quiz,
          quizListCubit: args.quizListCubit,
          draft: args.draft,
        ),
      );
    },
    QuizListRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.QuizListScreen(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          App.name,
          path: '/App',
          children: [
            _i7.RouteConfig(
              AuthenticationFlowRoute.name,
              path: 'auth',
              parent: App.name,
              children: [
                _i7.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: AuthenticationFlowRoute.name,
                  redirectTo: 'signup',
                  fullMatch: true,
                ),
                _i7.RouteConfig(
                  RegistrationRoute.name,
                  path: 'signup',
                  parent: AuthenticationFlowRoute.name,
                ),
                _i7.RouteConfig(
                  LoginRoute.name,
                  path: 'loginin',
                  parent: AuthenticationFlowRoute.name,
                ),
              ],
            ),
            _i7.RouteConfig(
              UnprotectedFlowRoute.name,
              path: '',
              parent: App.name,
              children: [
                _i7.RouteConfig(
                  LandingRoute.name,
                  path: '',
                  parent: UnprotectedFlowRoute.name,
                )
              ],
            ),
            _i7.RouteConfig(
              ProtectedFlowRoute.name,
              path: 'protected',
              parent: App.name,
              guards: [authGuard],
              children: [
                _i7.RouteConfig(
                  QuizEditorRoute.name,
                  path: 'quiz-admin/:id',
                  parent: ProtectedFlowRoute.name,
                ),
                _i7.RouteConfig(
                  QuizListRoute.name,
                  path: '',
                  parent: ProtectedFlowRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i7.RouteConfig(
          LoadingRoute.name,
          path: 'loading',
        ),
      ];
}

/// generated route for
/// [_i1.App]
class App extends _i7.PageRouteInfo<void> {
  const App({List<_i7.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/App',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i7.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: 'loading',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i1.AuthenticationFlow]
class AuthenticationFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthenticationFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthenticationFlowRoute.name,
          path: 'auth',
          initialChildren: children,
        );

  static const String name = 'AuthenticationFlowRoute';
}

/// generated route for
/// [_i1.UnprotectedFlow]
class UnprotectedFlowRoute extends _i7.PageRouteInfo<void> {
  const UnprotectedFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          UnprotectedFlowRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'UnprotectedFlowRoute';
}

/// generated route for
/// [_i1.ProtectedFlow]
class ProtectedFlowRoute extends _i7.PageRouteInfo<void> {
  const ProtectedFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProtectedFlowRoute.name,
          path: 'protected',
          initialChildren: children,
        );

  static const String name = 'ProtectedFlowRoute';
}

/// generated route for
/// [_i2.RegistrationScreen]
class RegistrationRoute extends _i7.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: 'signup',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'loginin',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.LandingScreen]
class LandingRoute extends _i7.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i5.QuizEditorScreen]
class QuizEditorRoute extends _i7.PageRouteInfo<QuizEditorRouteArgs> {
  QuizEditorRoute({
    _i8.Key? key,
    required String quizId,
    _i10.QuizEntity? quiz,
    _i11.QuizListCubit? quizListCubit,
    _i12.DraftEntity? draft,
  }) : super(
          QuizEditorRoute.name,
          path: 'quiz-admin/:id',
          args: QuizEditorRouteArgs(
            key: key,
            quizId: quizId,
            quiz: quiz,
            quizListCubit: quizListCubit,
            draft: draft,
          ),
          rawPathParams: {'id': quizId},
        );

  static const String name = 'QuizEditorRoute';
}

class QuizEditorRouteArgs {
  const QuizEditorRouteArgs({
    this.key,
    required this.quizId,
    this.quiz,
    this.quizListCubit,
    this.draft,
  });

  final _i8.Key? key;

  final String quizId;

  final _i10.QuizEntity? quiz;

  final _i11.QuizListCubit? quizListCubit;

  final _i12.DraftEntity? draft;

  @override
  String toString() {
    return 'QuizEditorRouteArgs{key: $key, quizId: $quizId, quiz: $quiz, quizListCubit: $quizListCubit, draft: $draft}';
  }
}

/// generated route for
/// [_i6.QuizListScreen]
class QuizListRoute extends _i7.PageRouteInfo<void> {
  const QuizListRoute()
      : super(
          QuizListRoute.name,
          path: '',
        );

  static const String name = 'QuizListRoute';
}
