import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Esti sigur ca vrei sa inchizi editorul fara sa salvezi?",
            style: theme.subtitleTextStyle),
        SizedBox(height: theme.spacing.medium),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.bad),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Da'),
            ),
            SizedBox(width: theme.spacing.medium),
            FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.good),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Salveaza'),
            ),
          ],
        ),
      ],
    ));
  }
}
