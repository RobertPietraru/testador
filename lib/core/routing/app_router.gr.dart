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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../features/authentication/presentation/screens/registration_screen.dart'
    as _i2;
import '../../features/testing/presentation/screens/home_screen.dart' as _i3;
import '../screens/landing_screen.dart' as _i4;
import 'app_router.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeWrapperRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeWrapper(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegistrationScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LandingScreen(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeWrapperRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              RegistrationRoute.name,
              path: 'sign-up',
              parent: HomeWrapperRoute.name,
            ),
            _i5.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: HomeWrapperRoute.name,
            ),
            _i5.RouteConfig(
              LandingRoute.name,
              path: '',
              parent: HomeWrapperRoute.name,
            ),
          ],
        ),
        _i5.RouteConfig(
          LoadingRoute.name,
          path: '/loading-screen',
        ),
      ];
}

/// generated route for
/// [_i1.HomeWrapper]
class HomeWrapperRoute extends _i5.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i5.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: '/loading-screen',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i2.RegistrationScreen]
class RegistrationRoute extends _i5.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: 'sign-up',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LandingScreen]
class LandingRoute extends _i5.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}
