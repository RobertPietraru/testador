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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../features/authentication/presentation/screens/registration_screen.dart'
    as _i2;
import '../screens/landing_screen.dart' as _i3;
import 'app_router.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeWrapper(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegistrationScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LandingScreen(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i4.RouteConfig(
              RegistrationRoute.name,
              path: 'sign-up',
              parent: HomeRoute.name,
            ),
            _i4.RouteConfig(
              LandingRoute.name,
              path: '',
              parent: HomeRoute.name,
            ),
          ],
        ),
        _i4.RouteConfig(
          LoadingRoute.name,
          path: '/loading-screen',
        ),
      ];
}

/// generated route for
/// [_i1.HomeWrapper]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i4.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: '/loading-screen',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i2.RegistrationScreen]
class RegistrationRoute extends _i4.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: 'sign-up',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i3.LandingScreen]
class LandingRoute extends _i4.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}
