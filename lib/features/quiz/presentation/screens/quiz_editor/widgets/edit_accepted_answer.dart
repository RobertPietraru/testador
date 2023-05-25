import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/custom_dialog.dart';
import '../../../../../../core/components/text_input_field.dart';
import '../../../../../../core/components/theme/app_theme.dart';
import '../cubit/quiz_editor_cubit.dart';

class EditAcceptedAnswerDialog extends StatefulWidget {
  final String initialValue;
  final int index;
  const EditAcceptedAnswerDialog(
      {super.key, required this.initialValue, required this.index});

  @override
  State<EditAcceptedAnswerDialog> createState() =>
      _EditAcceptedAnswerDialogState();
}

class _EditAcceptedAnswerDialogState extends State<EditAcceptedAnswerDialog> {
  late String value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final translator = AppLocalizations.of(context);
    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextInputField(
            onChanged: (e) {
              setState(() {
                value = e;
              });
            },
            initialValue: widget.initialValue,
            hint: translator.tapToModifyQuestion,
            showLabel: false,
          ),
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
                  context
                      .read<QuizEditorCubit>()
                      .removeAcceptedAnswer(index: widget.index);
                  Navigator.pop(context);
                },
                child:  Text('Sterge'),
              ),
              SizedBox(width: theme.spacing.small),
              FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.good),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
                onPressed: () {
                  context
                      .read<QuizEditorCubit>()
                      .updateAcceptedAnswer(index: widget.index, answer: value);
                  Navigator.pop(context);
                },
                child: const Text('Salveaza'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
