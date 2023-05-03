import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/features/authentication/presentation/auth_bloc/auth_bloc.dart';

import '../routing/app_router.gr.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          ListTile(
              onTap: () {},
              title: Text("Contact", style: theme.actionTextStyle)),
          ListTile(
              onTap: () {},
              title: Text("Descopera", style: theme.actionTextStyle)),
          ListTile(
              onTap: () {},
              title: Text("Alatura-te", style: theme.actionTextStyle)),
          ListTile(
              onTap: () {},
              title: Text("Creeaza", style: theme.actionTextStyle)),
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous is AuthAuthenticatedState &&
                current is AuthUnauthenticatedState,
            listener: (context, state) {
              if (state is AuthUnauthenticatedState) {
                context.router.popUntilRoot();
                context.router.root.push(const UnprotectedFlowRoute());
              }
            },
            builder: (context, state) => ListTile(
                onTap: state is AuthAuthenticatedState
                    ? () {
                        context.read<AuthBloc>().add(const AuthUserLoggedOut());
                      }
                    : () {
                        context.pushRoute(const AuthenticationFlowRoute());
                      },
                title: state is AuthAuthenticatedState
                    ? Text("Delogheaza-te",
                        style: theme.actionTextStyle.copyWith(color: theme.bad))
                    : Text("Logheaza-te", style: theme.actionTextStyle)),
          )
        ]),
      ),
    );
  }
}
