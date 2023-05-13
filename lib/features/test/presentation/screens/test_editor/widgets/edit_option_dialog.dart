import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/custom_dialog.dart';
import '../../../../../../core/components/text_input_field.dart';
import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';

class EditOptionDialog extends StatefulWidget {
  final MultipleChoiceOptionEntity entity;
  final int index;
  const EditOptionDialog(
      {super.key, required this.entity, required this.index});

  @override
  State<EditOptionDialog> createState() => _EditOptionDialogState();
}

class _EditOptionDialogState extends State<EditOptionDialog> {
  late String value;
  late bool isCorrect;

  @override
  void initState() {
    value = widget.entity.text ?? '';
    isCorrect = widget.entity.isCorrect;
    super.initState();
  }

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
          hint: 'Apasa pentru a edita raspunsul',
          backgroundColor: Colors.transparent,
          showLabel: false,
        ),
        CheckboxListTile(
          value: isCorrect,
          onChanged: (e) => setState(() => isCorrect = !isCorrect),
          title: const Text("Este corect?"),
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
                context.read<QuizEditorCubit>().updateCurrentQuestionOption(
                    optionIndex: widget.index,
                    newOption: MultipleChoiceOptionEntity(
                        text: value.isEmpty ? null : value,
                        isCorrect: isCorrect));
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
