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
import '../../features/testing/presentation/screens/home_screen.dart' as _i6;
import '../../features/testing/presentation/screens/test_screen.dart' as _i5;
import '../screens/landing_screen.dart' as _i4;
import 'app_router.dart' as _i1;
import 'route_guards.dart' as _i9;

class AppRouter extends _i7.RootStackRouter {
  AppRouter({
    _i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
    required this.authLoadingGuard,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i9.AuthLoadingGuard authLoadingGuard;

  final _i9.AuthGuard authGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
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
    LoadingRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
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
    TestAdminRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TestAdminRouteArgs>(
          orElse: () => TestAdminRouteArgs(testId: pathParams.getString('id')));
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.TestAdminScreen(
          key: args.key,
          testId: args.testId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          AuthenticationFlowRoute.name,
          path: '/auth',
          guards: [authLoadingGuard],
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
          path: '/',
          guards: [authLoadingGuard],
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
          path: '/protected',
          guards: [
            authGuard,
            authLoadingGuard,
          ],
          children: [
            _i7.RouteConfig(
              TestAdminRoute.name,
              path: 'test-admin/:id',
              parent: ProtectedFlowRoute.name,
            ),
            _i7.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: ProtectedFlowRoute.name,
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
/// [_i1.AuthenticationFlow]
class AuthenticationFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthenticationFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthenticationFlowRoute.name,
          path: '/auth',
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
          path: '/',
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
          path: '/protected',
          initialChildren: children,
        );

  static const String name = 'ProtectedFlowRoute';
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
/// [_i5.TestAdminScreen]
class TestAdminRoute extends _i7.PageRouteInfo<TestAdminRouteArgs> {
  TestAdminRoute({
    _i8.Key? key,
    required String testId,
  }) : super(
          TestAdminRoute.name,
          path: 'test-admin/:id',
          args: TestAdminRouteArgs(
            key: key,
            testId: testId,
          ),
          rawPathParams: {'id': testId},
        );

  static const String name = 'TestAdminRoute';
}

class TestAdminRouteArgs {
  const TestAdminRouteArgs({
    this.key,
    required this.testId,
  });

  final _i8.Key? key;

  final String testId;

  @override
  String toString() {
    return 'TestAdminRouteArgs{key: $key, testId: $testId}';
  }
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}
