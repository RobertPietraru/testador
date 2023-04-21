import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';

import '../../../../core/routing/app_router.gr.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const radius = 20.0;
    final theme = AppTheme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        width: 50.widthPercent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: theme.defaultBackgroundColor,
        ),
        child: Padding(
          padding: theme.standardPadding,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Logheaza-te",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: theme.spacing.mediumLarge),
                const Text(
                  "Completeaza campurile pentru a continua",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: theme.spacing.xxLarge),
                TextInputField(onChanged: (e) {}, hint: "Email"),
                SizedBox(height: theme.spacing.mediumLarge),
                TextInputField(onChanged: (e) {}, hint: "Parola"),
                SizedBox(height: theme.spacing.mediumLarge),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text("Ti-ai uitat parola?"))
                ]),
                SizedBox(height: theme.spacing.mediumLarge),
                LongButton(
                    onPressed: () {}, label: 'Logheaza-te', isLoading: false),
                SizedBox(height: theme.spacing.xxLarge),
                Center(
                  child: TextButton(
                      onPressed: () {
                        context.popRoute();
                        context.pushRoute(const RegistrationRoute());
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Nu ai cont? ",
                            style: theme.actionTextStyle,
                          ),
                          TextSpan(
                              text: "Inregistreaza-te",
                              style: theme.actionTextStyle
                                  .copyWith(color: theme.companyColor)),
                        ]),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
