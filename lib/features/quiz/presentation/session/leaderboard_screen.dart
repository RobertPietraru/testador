import 'package:flutter/material.dart';
import 'package:testador/core/components/components.dart';
import 'package:testador/core/utils/split_string_into_blocks.dart';
import 'package:testador/features/quiz/domain/entities/session/player_entity.dart';
import 'package:testador/features/quiz/presentation/session/cubit/session_admin_cubit.dart';

class LeaderboardScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final SessionAdminMatchState state;
  const LeaderboardScreen({
    super.key,
    required this.state,
    required this.onContinue,
  });

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final ScrollController controller = ScrollController();
  int total = 0;
  late final List<PlayerEntity> sortedPlayers;
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
  void initState() {
    sortedPlayers = widget.state.session.students.toList();
    sortedPlayers.sort((a, b) => b.score.compareTo(a.score));

    super.initState();
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
                  padding: theme.standardPadding.copyWith(top: 0),
                  child: Center(
                    child: Text(
                      "Clasament",
                      style: theme.subtitleTextStyle,
                    ),
                  ))
            ]))
          ];
        },
        body: ListView.separated(
            separatorBuilder: (context, index) =>
                SizedBox(height: theme.spacing.small),
            itemCount: sortedPlayers.length,
            itemBuilder: (context, index) => Padding(
                  padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
                  child: ListTile(
                    trailing:
                        Text(sortedPlayers[index].score.toInt().toString()),
                    tileColor: theme.secondaryColor.withOpacity(0.5),
                    title: Text(sortedPlayers[index].name),
                  ),
                )),
      ),
    );
  }
}
