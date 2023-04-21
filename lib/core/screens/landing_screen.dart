import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/buttons/long_button.dart';
import 'package:testador/core/components/gradient_text.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final button = LongButton(
        textGradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF000AFF),
              Color(0xFFFF005A),
            ]),
        onPressed: () {},
        label: 'Incepe',
        isLoading: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
            const CustomAppBar(),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SizedBox(
                      height: button.height,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ajuta-ti elevi si ajuta-te pe tine",
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
                    SizedBox(width: 20.widthPercent, child: button),
                    const SizedBox(),
                  ]),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}