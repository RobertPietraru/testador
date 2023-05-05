import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';

import '../../../../core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';

class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen({super.key, @PathParam('id') required this.testId, required this.entity});
  final String testId;
  final TestEntity entity;

  @override
  Widget build(BuildContext context) {
    return const TheTestScreen();
  }
}

class TheTestScreen extends StatelessWidget {
  const TheTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    const String testTitle = "Evaluare Nationala la Limba si Literatura Romana";
    const String testDescription =
        "Un test cu scopul de a verifica cunostintele pe care le are cineva la romana";
    const String imageUrl = 'https://picsum.photos/800/600?grayscale';
    const bool isPublic = false;
    return Scaffold(
      backgroundColor: theme.defaultBackgroundColor.withOpacity(0.9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(testTitle),
            actions: [
              PopupMenuButton(
                icon: isPublic
                    ? Icon(
                        Icons.public_off,
                        color: theme.bad,
                      )
                    : Icon(Icons.public, color: theme.good),
                tooltip: 'Privat/Public',
                itemBuilder: (context) => [
                  isPublic
                      ? PopupMenuItem(
                          child: MenuItem(
                            title: 'Fa privat',
                            icon: Icons.public_off,
                            color: theme.bad,
                          ),
                          onTap: () {},
                        )
                      : PopupMenuItem(
                          onTap: () {},
                          child: MenuItem(
                            title: 'Fa public',
                            icon: Icons.public,
                            color: theme.good,
                          ),
                        ),
                ],
              ),
              PopupMenuButton(
                tooltip: 'Meniu',
                icon: const Icon(Icons.menu),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Share.shareWithResult('text');
                      // Share.share('asdfasdf');
                    },
                    child: const MenuItem(
                      title: 'Impartaseste',
                      icon: Icons.share,
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: const MenuItem(
                      title: 'Schimba imaginea',
                      icon: Icons.image,
                    ),
                  )
                ],
              )
            ],
            stretch: true,
            expandedHeight: DeviceSize.isDesktopMode ? 200 : 250,
            titleSpacing: theme.standardPadding.left,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.fadeTitle],
              collapseMode: CollapseMode.pin,
              titlePadding: theme.standardPadding,
              background: Opacity(
                opacity: 0.5,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text(testDescription),
            ),
            floating: !DeviceSize.isDesktopMode,
            // snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: theme.standardPadding,
                      child: Container(
                          color: theme.defaultBackgroundColor,
                          padding: theme.standardPadding,
                          child: QuestionWidget(
                              isEditMode: false,
                              index: index,
                              question: 'Care e sensul vietii',
                              type: QuestionType.multipleChoice,
                              options: [
                                MultipleChoiceOption(
                                    answer: "Sa imparti", isRight: true),
                                MultipleChoiceOption(
                                    answer: "Sa daruiesti", isRight: true),
                                MultipleChoiceOption(
                                    answer: "Sa dormi", isRight: false),
                                MultipleChoiceOption(
                                    answer: "Toate de mai sus", isRight: false),
                              ])),
                    ),
                    FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => QuestionCreationDialog());
                        },
                        child: const Icon(Icons.add))
                  ],
                );
              },
              childCount: 40,
            ),
          ),
          // SliverFillRemaining(
          //   child: ListView.separated(
          //       padding: EdgeInsets.zero,
          //       separatorBuilder: (context, index) => FloatingActionButton(
          //           onPressed: () {}, child: const Icon(Icons.add)),
          //       itemCount: 50,
          //       itemBuilder: (context, index) => Padding(
          //             padding: theme.standardPadding,
          //             child: Container(
          //                 color: theme.defaultBackgroundColor,
          //                 padding: theme.standardPadding,
          //                 child: QuestionWidget(
          //                     isEditMode: false,
          //                     index: index,
          //                     question: 'Care e sensul vietii',
          //                     type: QuestionType.multipleChoice,
          //                     options: [
          //                       MultipleChoiceOption(
          //                           answer: "Sa imparti", isRight: true),
          //                       MultipleChoiceOption(
          //                           answer: "Sa daruiesti", isRight: true),
          //                       MultipleChoiceOption(
          //                           answer: "Sa dormi", isRight: false),
          //                       MultipleChoiceOption(
          //                           answer: "Toate de mai sus", isRight: false),
          //                     ])),
          //           )),
          // ),
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
