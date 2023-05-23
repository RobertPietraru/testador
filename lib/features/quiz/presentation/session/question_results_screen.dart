import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/components.dart';
import 'package:testador/core/utils/split_string_into_blocks.dart';
import 'package:testador/features/quiz/domain/entities/question_entity.dart';
import 'package:testador/features/quiz/presentation/session/session_admin_cubit/session_admin_cubit.dart';
import 'package:testador/features/quiz/presentation/session/widgets/session_option_widget.dart';

class QuestionResultsScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final SessionAdminMatchState state;
  const QuestionResultsScreen(
      {super.key, required this.state, required this.onContinue});

  @override
  State<QuestionResultsScreen> createState() => _QuestionResultsScreenState();
}

class _QuestionResultsScreenState extends State<QuestionResultsScreen> {
  final ScrollController controller = ScrollController();
  int total = 0;

  List<int> calculate() {
    Map<int, int> answerCount = {};
    for (var answer in widget.state.session.answers) {
      final before = answerCount[answer.optionIndex];
      if (before == null) {
        answerCount[answer.optionIndex!] = 0;
      } else {
        answerCount[answer.optionIndex!] =
            answerCount[answer.optionIndex!]! + 1;
      }
      total++;
    }
    return answerCount.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final state = widget.state;
    final List<int> results = calculate();
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(splitStringIntoBlocks(widget.state.session.id),
              style: theme.titleTextStyle),
          trailing: [
            AppBarButton(text: 'Continua', onPressed: widget.onContinue)
          ]),
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                  padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${(state.currentQuestionIndex + 1).toString()} ${state.currentQuestion.text ?? "Cineva a uitat sa puna aici o intrebare 😁"}",
                        style: theme.subtitleTextStyle,
                      ),
                      _ResultsChart(
                        choices: results,
                        options: widget.state.currentQuestion.options,
                      ),
                    ],
                  ))
            ]))
          ];
        },
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: widget.state.currentQuestion.options.length,
            itemBuilder: (context, index) => SessionOptionWidget(
                  index: index,
                  option: widget.state.currentQuestion.options[index],
                  isSelected: false,
                  onPressed: null,
                )),
      ),
    );
  }
}

class _ResultsChart extends StatelessWidget {
  final List<int> choices;
  final List<MultipleChoiceOptionEntity> options;
  const _ResultsChart({required this.choices, required this.options});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(theme),
                ),
              ),
            ),
          ),
          // Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: List.generate(
          //         widget.choices.length,
          //         (index) => Indicator(
          //               color: theme.getColor(index),
          //               text: widget.choices[index].toString(),
          //               isSquare: true,
          //             ))),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(AppThemeData theme) {
    return List.generate(choices.length, (i) {
      final isCorrect = options[i].isCorrect;
      final fontSize = isCorrect ? 25.0 : 16.0;
      final radius = isCorrect ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      int count = choices[i];
      return PieChartSectionData(
        color: theme.getColor(i),
        badgeWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(count.toString(), style: theme.subtitleTextStyle),
            if (isCorrect) const SizedBox(width: 3),
            if (isCorrect) const Icon(Icons.done),
          ],
        ),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
