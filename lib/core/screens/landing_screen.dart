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
    final button =
        LongButton(onPressed: () {}, label: 'Incepe', isLoading: false);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
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
                  GradientText(
                    "Pietrocka Testing",
                    style: theme.largetitleTextStyle.copyWith(),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          // Color(0xFF00ff87),
                          // Color(0xFF60efff),
                          Color(0xFFff0f7b),
                          Color(0xFFf89b29),
                        ]),
                  ),
                  Text(
                    "Evaluare, fara stres",
                    style: theme.titleTextStyle
                        .copyWith(color: theme.secondaryColor),
                  ),
                ],
              ),
              SizedBox(width: 20.widthPercent, child: button),
              const SizedBox(),
            ]),
      ),
    );
  }
}
