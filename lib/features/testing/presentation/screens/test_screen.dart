import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';

import '../../../../core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';

class TestAdminScreen extends StatelessWidget {
  const TestAdminScreen({super.key, @PathParam('id') required this.testId});
  final String testId;

  @override
  Widget build(BuildContext context) {
    return TheTestScreen();
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
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: const Text(testTitle),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
            ],
            pinned: true,
            expandedHeight: 200,
            titleSpacing: theme.standardPadding.left,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: theme.standardPadding,
              background: Opacity(
                opacity: 0.5,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(testDescription),
            ),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                    padding: theme.standardPadding,
                    child: QuestionWidget(index: index));
              },
              childCount: 40,
            ),
          ),
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

class QuestionWidget extends StatelessWidget {
  final int index;
  const QuestionWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    const question = "Care e sensul vietii?";
    const type = QuestionType.multipleChoice;
    final theme = AppTheme.of(context);

    final List<MultipleChoiceOption> options = [
      MultipleChoiceOption(answer: "Sa imparti", isRight: true),
      MultipleChoiceOption(answer: "Sa daruiesti", isRight: true),
      MultipleChoiceOption(answer: "Sa dormi", isRight: false),
      MultipleChoiceOption(answer: "Toate de mai sus", isRight: false),
    ];

    return Container(
      child: Column(
        children: [
          buildQuestionAndOptions(index, question, theme),
          // if (type == QuestionType.multipleChoice)
          ...options
              .map((option) => ListTile(
                    leading: option.isRight
                        ? Icon(Icons.done, color: theme.good)
                        : Icon(Icons.close, color: theme.bad),
                    title: Text(option.answer),
                  ))
              .toList()
        ],
      ),
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
              child: buildItem(title: 'Muta mai sus', icon: Icons.arrow_upward),
            ),
            PopupMenuItem(
              onTap: () {},
              child:
                  buildItem(title: 'Muta mai jos', icon: Icons.arrow_downward),
            ),
            PopupMenuItem(
              onTap: () {},
              child: buildItem(title: 'Modifica', icon: Icons.edit),
            ),
            PopupMenuItem(
              onTap: () {},
              child: buildItem(
                icon: Icons.delete,
                title: 'Sterge',
                color: Colors.red,
              ),
            )
          ],
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }

  ListTile buildItem(
      {required String title, required IconData icon, Color? color}) {
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
