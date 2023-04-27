import 'package:flutter/material.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.radius = 20,
    required this.child,
  });

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          child: child,
        ),
      ),
    );
  }
}