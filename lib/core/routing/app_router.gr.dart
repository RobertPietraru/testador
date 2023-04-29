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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../features/authentication/presentation/screens/registration_screen.dart'
    as _i2;
import '../../features/testing/presentation/screens/home_screen.dart' as _i5;
import '../../features/testing/presentation/screens/test_screen.dart' as _i4;
import '../screens/landing_screen.dart' as _i3;
import 'app_router.dart' as _i1;
import 'route_guards.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthenticationFlowRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationFlow(),
      );
    },
    UnprotectedFlowRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.UnprotectedFlow(),
      );
    },
    ProtectedFlowRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProtectedFlow(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegistrationScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LandingScreen(),
      );
    },
    TestAdminRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TestAdminRouteArgs>(
          orElse: () => TestAdminRouteArgs(testId: pathParams.getString('id')));
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.TestAdminScreen(
          key: args.key,
          testId: args.testId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          AuthenticationFlowRoute.name,
          path: '/auth',
          children: [
            _i6.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticationFlowRoute.name,
              redirectTo: 'sign-up',
              fullMatch: true,
            ),
            _i6.RouteConfig(
              RegistrationRoute.name,
              path: 'sign-up',
              parent: AuthenticationFlowRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          UnprotectedFlowRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              LandingRoute.name,
              path: '',
              parent: UnprotectedFlowRoute.name,
            )
          ],
        ),
        _i6.RouteConfig(
          ProtectedFlowRoute.name,
          path: '/protected',
          guards: [authGuard],
          children: [
            _i6.RouteConfig(
              TestAdminRoute.name,
              path: 'test-admin/:id',
              parent: ProtectedFlowRoute.name,
            ),
            _i6.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: ProtectedFlowRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          LoadingRoute.name,
          path: 'loading',
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticationFlow]
class AuthenticationFlowRoute extends _i6.PageRouteInfo<void> {
  const AuthenticationFlowRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthenticationFlowRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthenticationFlowRoute';
}

/// generated route for
/// [_i1.UnprotectedFlow]
class UnprotectedFlowRoute extends _i6.PageRouteInfo<void> {
  const UnprotectedFlowRoute({List<_i6.PageRouteInfo>? children})
      : super(
          UnprotectedFlowRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'UnprotectedFlowRoute';
}

/// generated route for
/// [_i1.ProtectedFlow]
class ProtectedFlowRoute extends _i6.PageRouteInfo<void> {
  const ProtectedFlowRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ProtectedFlowRoute.name,
          path: '/protected',
          initialChildren: children,
        );

  static const String name = 'ProtectedFlowRoute';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i6.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: 'loading',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i2.RegistrationScreen]
class RegistrationRoute extends _i6.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: 'sign-up',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i3.LandingScreen]
class LandingRoute extends _i6.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i4.TestAdminScreen]
class TestAdminRoute extends _i6.PageRouteInfo<TestAdminRouteArgs> {
  TestAdminRoute({
    _i7.Key? key,
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

  final _i7.Key? key;

  final String testId;

  @override
  String toString() {
    return 'TestAdminRouteArgs{key: $key, testId: $testId}';
  }
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}
