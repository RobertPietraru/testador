import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/theme/app_theme.dart';
import '../../../../domain/entities/question_entity.dart';
import '../cubit/test_editor_cubit.dart';
import 'edit_option_dialog.dart';

class OptionWidget extends StatefulWidget {
  final int index;
  final MultipleChoiceOptionEntity option;
  const OptionWidget({
    super.key,
    required this.index,
    required this.option,
  });

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  Color getColor(int index) {
    return [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.pink,
      Colors.purple
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.option.text != null;
    final theme = AppTheme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<QuizEditorCubit>(),
              child: EditOptionDialog(
                entity: widget.option,
                index: widget.index,
              ),
            ),
          );
        },
        child: Ink(
          color: isEnabled ? getColor(widget.index) : theme.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => context
                          .read<QuizEditorCubit>()
                          .updateCurrentQuestionOption(
                              optionIndex: widget.index,
                              newOption: MultipleChoiceOptionEntity(
                                  text: widget.option.text,
                                  isCorrect: !widget.option.isCorrect)),
                      icon: Icon(
                          widget.option.isCorrect ? Icons.done : Icons.close,
                          color: Colors.white)),
                ],
              ),
              Center(
                child: Text(
                  widget.option.text ?? "Optiunea ${widget.index + 1}",
                  style: TextStyle(
                      color: isEnabled ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
