import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/drawer.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/features/authentication/presentation/auth_bloc/auth_bloc.dart';
import 'package:testador/features/authentication/presentation/screens/login/cubit/login_cubit.dart';
import 'package:testador/injection.dart';

import '../../../../../core/components/custom_dialog.dart';
import '../../../../../core/routing/app_router.gr.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: _LoginBlocWrapper(child: _LoginView()),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: _LoginBlocWrapper(child: _LoginView()),
    );
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: theme.standardPadding,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Logheaza-te",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: theme.spacing.mediumLarge),
            Text(
              "Completeaza campurile pentru a continua",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: theme.spacing.xxLarge),
            TextInputField(onChanged: (e) {}, hint: "Email"),
            SizedBox(height: theme.spacing.mediumLarge),
            TextInputField(onChanged: (e) {}, hint: "Parola"),
            SizedBox(height: theme.spacing.mediumLarge),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                  onPressed: () {}, child: const Text("Ti-ai uitat parola?"))
            ]),
            SizedBox(height: theme.spacing.mediumLarge),
            LongButton(
                onPressed: () {}, label: 'Logheaza-te', isLoading: false),
            SizedBox(height: theme.spacing.xxLarge),
            Center(
              child: TextButton(
                  onPressed: () {
                    context.router.replace(const RegistrationRoute());
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Nu ai cont? ",
                        style: theme.actionTextStyle
                            .copyWith(color: theme.primaryColor),
                      ),
                      TextSpan(
                          text: "Inregistreaza-te",
                          style: theme.actionTextStyle.copyWith(
                            color: theme.companyColor,
                          )),
                    ]),
                  )),
            )
          ]),
    );
  }
}

class _LoginBlocWrapper extends StatelessWidget {
  final Widget child;
  const _LoginBlocWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(locator(), authBloc: context.read<AuthBloc>()),
      child: child,
    );
  }
}
