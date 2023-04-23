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
import '../../features/testing/presentation/screens/home_screen.dart' as _i3;
import '../../features/testing/presentation/screens/test_screen.dart' as _i5;
import '../screens/landing_screen.dart' as _i4;
import 'app_router.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeWrapperRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeWrapper(),
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
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LandingScreen(),
      );
    },
    TestAdminRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TestAdminRouteArgs>(
          orElse: () => TestAdminRouteArgs(testId: pathParams.getString('id')));
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.TestAdminScreen(
          key: args.key,
          testId: args.testId,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          HomeWrapperRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              RegistrationRoute.name,
              path: 'sign-up',
              parent: HomeWrapperRoute.name,
            ),
            _i6.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: HomeWrapperRoute.name,
            ),
            _i6.RouteConfig(
              LandingRoute.name,
              path: '',
              parent: HomeWrapperRoute.name,
            ),
            _i6.RouteConfig(
              TestAdminRoute.name,
              path: 'test-admin/:id',
              parent: HomeWrapperRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          LoadingRoute.name,
          path: '/loading-screen',
        ),
      ];
}

/// generated route for
/// [_i1.HomeWrapper]
class HomeWrapperRoute extends _i6.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i6.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: '/loading-screen',
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
/// [_i3.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LandingScreen]
class LandingRoute extends _i6.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i5.TestAdminScreen]
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
