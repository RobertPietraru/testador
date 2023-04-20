import 'package:flutter/material.dart';
import 'package:testador/core/components/theme/device_size.dart';

import '../theme/app_theme.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
    this.height = 55,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SizedBox(
      width: 100.widthPercent,
      height: height,
      child: TextButton(
        onPressed: !isLoading ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator(
                color: theme.defaultBackgroundColor,
              )
            else
              Text(label,
                  style: theme.subtitleTextStyle
                      .copyWith(color: theme.defaultBackgroundColor)),
          ],
        ),
        style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStateColor.resolveWith((states) => theme.secondaryColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return theme.primaryColor.withOpacity(0.2);
              }

              return theme.primaryColor;
            },
          ),
        ),
      ),
    );
  }
}
