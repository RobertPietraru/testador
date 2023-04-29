import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/drawer.dart';
import 'package:testador/core/components/theme/device_size.dart';

import '../../../../core/components/buttons/long_button.dart';
import '../../../../core/components/text_input_field.dart';
import '../../../../core/components/theme/app_theme.dart';
import '../widgets/login_dialog.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const AppDrawer(),
      body: Center(
        child: SizedBox(
          width: DeviceSize.isDesktopMode ? 50.widthPercent : null,
          child: Padding(
            padding: theme.standardPadding,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inregistreaza-te",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: theme.primaryColor),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: theme.spacing.mediumLarge),
                  Text(
                    "Completeaza campurile pentru a continua",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: theme.primaryColor),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: theme.spacing.xxLarge),
                  TextInputField(onChanged: (e) {}, hint: "Email"),
                  SizedBox(height: theme.spacing.mediumLarge),
                  TextInputField(onChanged: (e) {}, hint: "Parola"),
                  SizedBox(height: theme.spacing.mediumLarge),
                  TextInputField(onChanged: (e) {}, hint: "Confirmare parola"),
                  SizedBox(height: theme.spacing.xxLarge),
                  LongButton(
                      onPressed: () {},
                      label: 'Inregistreaza-te',
                      isLoading: false),
                  SizedBox(height: theme.spacing.xxLarge),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          context.popRoute();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const LoginDialog(),
                          );
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Ai deja cont? ",
                              style: theme.actionTextStyle
                                  .copyWith(color: theme.primaryColor),
                            ),
                            TextSpan(
                                text: "Logheaza-te",
                                style: theme.actionTextStyle
                                    .copyWith(color: theme.companyColor)),
                          ]),
                        )),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
