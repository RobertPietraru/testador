import 'package:flutter/material.dart';
import 'package:testador/core/components/components.dart';
import 'package:testador/core/utils/split_string_into_blocks.dart';
import 'package:testador/features/quiz/domain/entities/session/player_entity.dart';
import 'package:testador/features/quiz/presentation/session/session_admin_cubit/session_admin_cubit.dart';

class PodiumScreen extends StatefulWidget {
  final VoidCallback onLeave;
  final SessionAdminMatchState state;
  const PodiumScreen({
    super.key,
    required this.state,
    required this.onLeave,
  });

  @override
  State<PodiumScreen> createState() => _PodiumScreenState();
}

class _PodiumScreenState extends State<PodiumScreen> {
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
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(splitStringIntoBlocks(widget.state.session.id),
            style: theme.titleTextStyle),
        trailing: [],
      ),
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                  padding: theme.standardPadding.copyWith(top: 0),
                  child: Center(
                    child: Text("Clasament", style: theme.subtitleTextStyle),
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
                    leading: Text((index + 1).toString()),
                    trailing:
                        Text(sortedPlayers[index].score.toInt().toString()),
                    tileColor: index < 4
                        ? Colors.amber
                        : theme.secondaryColor.withOpacity(0.5),
                    title: Text(sortedPlayers[index].name),
                  ),
                )),
      ),
    );
  }
}