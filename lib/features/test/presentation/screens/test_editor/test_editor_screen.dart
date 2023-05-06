import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/presentation/screens/test_editor/test_editor_retrival/test_editor_retrival_widget.dart';

import '../../../../../core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';

class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen(
      {super.key, @PathParam('id') required this.testId, this.entity});
  final String testId;
  final TestEntity? entity;

  @override
  Widget build(BuildContext context) {
    return TestEditorRetrivalWidget(
      testId: testId,
      entity: entity,
      builder: (state) => _TestScreen(testEntity: state.entity),
    );
  }
}

class _TestScreen extends StatelessWidget {
  final TestEntity testEntity;

  const _TestScreen({required this.testEntity});
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: theme.defaultBackgroundColor.withOpacity(0.9),
      appBar: CustomAppBar(
        title: Container(),
        trailing: [],
      ),
      body: Column(
        children: [
          Text('asdf'),
          FilledButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.good),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ))),
            onPressed: () {},
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}

class QuestionCreationDialog extends StatelessWidget {
  const QuestionCreationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChoiceWidget(
            icon: Icons.done,
            label: 'Bifat',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ChoiceWidget(
            icon: Icons.edit,
            label: 'Raspuns',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ChoiceWidget(
            icon: Icons.school,
            label: 'Adevarat/Falst',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Function() onPressed;

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final double size = 10.widthPercent;
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => setState(() => isPressed = true),
      onTapUp: (details) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isPressed
                  ? theme.primaryColor.withOpacity(0.8)
                  : theme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: theme.defaultBackgroundColor,
              size: size / 2,
            ),
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            widget.label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

enum QuestionType {
  multipleChoice,
  answer,
  trueOrFalse,
}

class MultipleChoiceOption {
  final String answer;
  final bool isRight;

  MultipleChoiceOption({required this.answer, required this.isRight});
}

class QuestionWidget extends StatefulWidget {
  final int index;
  final QuestionType type;
  final String question;
  final List<MultipleChoiceOption>? options;
  final bool isEditMode;
  const QuestionWidget({
    super.key,
    required this.index,
    required this.type,
    required this.question,
    this.options,
    required this.isEditMode,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late final List<MultipleChoiceOption> _options;
  @override
  void initState() {
    _options = widget.options ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Column(
      children: [
        buildQuestionAndOptions(widget.index, widget.question, theme),
        buildAnswerSection(
          theme: theme,
          onDelete: (option) {},
        ),
      ],
    );
  }

  Widget buildAnswerSection({
    required AppThemeData theme,
    Function(MultipleChoiceOption option)? onDelete,
  }) {
    switch (widget.type) {
      case QuestionType.answer:
        return const Text("sadf");
      case QuestionType.multipleChoice:
        if (widget.isEditMode) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _options.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildOption(_options[index], index, theme);
            },
          );
        } else {
          return buildReorderableList(theme);
        }

      default:
        return Container();
    }
  }

  ReorderableListView buildReorderableList(AppThemeData theme) {
    return ReorderableListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final option = _options[index];
        return buildOption(option, index, theme);
      },
      itemCount: _options.length,
      onReorder: (oldIndex, newIndex) {
        print(oldIndex);
        final temp = _options[oldIndex];
        _options.removeAt(oldIndex);
        if (oldIndex < newIndex) {
          _options.insert(newIndex - 1, temp);
        } else {
          _options.insert(newIndex, temp);
        }
        setState(() {});
      },
    );
  }

  ListTile buildOption(
    MultipleChoiceOption option,
    int index,
    AppThemeData theme, {
    Function(MultipleChoiceOption option)? onDelete,
    Function(MultipleChoiceOption option)? onEdit,
  }) {
    return ListTile(
      trailing: widget.isEditMode
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => onEdit?.call(option),
                    icon: const Icon(
                      Icons.edit,
                    )),
                IconButton(
                    onPressed: () => onDelete?.call(option),
                    icon: Icon(
                      Icons.delete,
                      color: theme.bad,
                    )),
              ],
            )
          : null,
      key: ValueKey(option),
      leading: IconButton(
          onPressed: () => setState(() => _options[index] =
              MultipleChoiceOption(
                  answer: option.answer, isRight: !option.isRight)),
          icon: option.isRight
              ? Icon(Icons.done, color: theme.good)
              : Icon(Icons.close, color: theme.bad)),
      title: Text(option.answer),
    );
  }

  Row buildQuestionAndOptions(int index, String question, AppThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "#${index + 1} $question",
          style: theme.informationTextStyle,
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {},
              child: MenuItem(title: 'Muta mai sus', icon: Icons.arrow_upward),
            ),
            PopupMenuItem(
              onTap: () {},
              child:
                  MenuItem(title: 'Muta mai jos', icon: Icons.arrow_downward),
            ),
            PopupMenuItem(
              onTap: () {},
              child: MenuItem(title: 'Modifica', icon: Icons.edit),
            ),
            PopupMenuItem(
              onTap: () {},
              child: MenuItem(
                icon: Icons.delete,
                title: 'Sterge',
                color: Colors.red,
              ),
            )
          ],
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.color,
  });

  final String title;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}
