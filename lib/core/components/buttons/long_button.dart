import 'package:flutter/material.dart';
import 'package:testador/core/components/gradient_text.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/core/components/theme/device_size.dart';

import '../theme/app_theme.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
    this.height = 45,
    this.textGradient,
    this.color,
  }) : super(key: key);
  final Gradient? textGradient;

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final color = this.color ?? theme.primaryColor;
    return SizedBox(
      width: 100.widthPercent,
      height: height,
      child: TextButton(
        onPressed: !isLoading ? onPressed : null,
        style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStateColor.resolveWith((states) => theme.secondaryColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return color.withOpacity(0.2);
              }

              return color;
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator(
                color: theme.defaultBackgroundColor,
              )
            else
              buildText(theme),
          ],
        ),
      ),
    );
  }

  Widget buildText(AppThemeData theme) {
    if (textGradient == null) {
      return Text(label,
          style: theme.subtitleTextStyle
              .copyWith(color: theme.defaultBackgroundColor));
    } else {
      return GradientText(label,
          gradient: textGradient!,
          style: theme.subtitleTextStyle
              .copyWith(color: theme.defaultBackgroundColor));
    }
  }
}
