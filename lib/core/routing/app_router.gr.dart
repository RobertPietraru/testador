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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../screens/landing_screen.dart' as _i2;
import 'app_router.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeWrapper(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoadingScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LandingScreen(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i3.RouteConfig(
              LandingRoute.name,
              path: '',
              parent: HomeRoute.name,
            )
          ],
        ),
        _i3.RouteConfig(
          LoadingRoute.name,
          path: '/loading-screen',
        ),
      ];
}

/// generated route for
/// [_i1.HomeWrapper]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i3.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: '/loading-screen',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i2.LandingScreen]
class LandingRoute extends _i3.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '',
        );

  static const String name = 'LandingRoute';
}
