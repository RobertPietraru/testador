import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/features/authentication/presentation/auth_bloc/auth_bloc.dart';

import '../routing/app_router.gr.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Color(0xFF000AFF),
              Color(0xFFFF005A),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomAppBar(mainColor: Colors.white),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ajuta-ti elevii si ajuta-te pe tine",
                          style: theme.largetitleTextStyle
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Evaluare, fara stres",
                          style: theme.titleTextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: theme.spacing.xxLarge),
                    SizedBox(
                        width: DeviceSize.isDesktopMode
                            ? 20.widthPercent
                            : 70.widthPercent,
                        child: LongButton(
                          textGradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFF000AFF),
                                Color(0xFFFF005A),
                              ]),
                          onPressed: () {
                            if (context.read<AuthBloc>().state
                                is AuthAuthenticatedState) {
                              context.router.root
                                  .push(const ProtectedFlowRoute());
                            } else {
                              context.router.root
                                  .push(const AuthenticationFlowRoute());
                            }
                          },
                          color: theme.defaultBackgroundColor,
                          label: 'Incepe',
                          isLoading: false,
                        )),
                    const SizedBox(),
                  ]),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
