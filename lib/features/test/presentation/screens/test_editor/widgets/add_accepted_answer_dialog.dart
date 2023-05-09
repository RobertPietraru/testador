import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/custom_dialog.dart';
import '../../../../../../core/components/text_input_field.dart';
import '../../../../../../core/components/theme/app_theme.dart';
import '../cubit/test_editor_cubit.dart';

class AcceptedAnswerCreationDialog extends StatefulWidget {
  const AcceptedAnswerCreationDialog({super.key});

  @override
  State<AcceptedAnswerCreationDialog> createState() =>
      _AcceptedAnswerCreationDialogState();
}

class _AcceptedAnswerCreationDialogState
    extends State<AcceptedAnswerCreationDialog> {
  String value = "";
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextInputField(
          initialValue: value,
          onChanged: (e) => setState(() => value = e),
          hint: 'Raspuns acceptat',
          backgroundColor: Colors.transparent,
          showLabel: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.good),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: () {
                if (value.isNotEmpty) {
                  context
                      .read<TestEditorCubit>()
                      .addAcceptedAnswer(answer: value);
                }
                Navigator.pop(context);
              },
              child: const Text('Salveaza'),
            )
          ],
        )
      ],
    ));
  }
}