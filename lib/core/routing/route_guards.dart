import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/routing/app_router.gr.dart';
import 'package:testador/features/authentication/presentation/auth_bloc/auth_bloc.dart';

class AuthGuard extends AutoRedirectGuardBase {
  final AuthBloc authBloc;
  final BuildContext context;

  late final StreamSubscription<AuthState> subscription;
  AuthState? state;
  AuthGuard({required this.context, required this.authBloc}) {
    subscription = authBloc.stream.listen((event) {
      state = event;
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    print(context.read<AuthBloc>().state);
    if (context.read<AuthBloc>().state.userEntity != null) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(const AuthenticationFlowRoute());
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async {
    return true;
  }
}

class AuthLoadingGuard extends AutoRedirectGuardBase {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> subscription;
  final BuildContext context;

  AuthState? state;
  AuthLoadingGuard({required this.context, required this.authBloc}) {
    subscription = authBloc.stream.listen((event) {
      state = event;
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    if (state is! AuthUninitialisedState) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(const AuthenticationFlowRoute());
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async {
    return true;
  }
}
