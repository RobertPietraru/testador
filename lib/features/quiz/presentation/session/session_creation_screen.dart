import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';
import 'package:testador/features/quiz/presentation/session/cubit/session_cubit.dart';
import 'package:testador/injection.dart';

import '../../../../core/components/theme/app_theme.dart';
import '../../../../core/components/theme/device_size.dart';

class QuizSessionCreationScreen extends StatelessWidget {
  final QuizEntity quiz;
  const QuizSessionCreationScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SessionCubit(locator(), locator(), locator(), locator(), quiz: quiz),
      child: _QuizSessionCreationScreen(),
    );
  }
}

class _QuizSessionCreationScreen extends StatelessWidget {
  String splitCode(String code, {int length = 3}) {
    List<String> blocks = [];
    for (int i = 0; i < code.length; i += length) {
      if (i + length <= code.length) {
        blocks.add(code.substring(i, i + length));
      } else {
        blocks.add(code.substring(i));
      }
    }
    return blocks.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<SessionCubit>().deleteAndUnsubscribe();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          trailing: [
            BlocBuilder<SessionCubit, SessionState>(
              builder: (context, state) {
                if (state is! SessionInGameState) {
                  return Container();
                }
                final hasStudents = state.session.students.isNotEmpty;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            hasStudents ? theme.good : theme.secondaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ))),
                    onPressed: hasStudents ? () {} : null,
                    onLongPress: () {},
                    child: const Text('Incepe'),
                  ),
                );
              },
            )
          ],
        ),
        body: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
            if (state is! SessionInGameState) {
              return const Center(child: CircularProgressIndicator());
            }
            final session = state.session;
            return Padding(
              padding: theme.standardPadding,
              child: Column(children: [
                Text("Se creaza acum sesiunea ta de joc",
                    style: theme.titleTextStyle, textAlign: TextAlign.center),
                SizedBox(height: theme.spacing.large),
                Card(
                  elevation: 25,
                  shadowColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onLongPress: () async {
                      await Clipboard.setData(
                          ClipboardData(text: state.session.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Copiat codul")));
                    },
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: state.session.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Copiat codul")));
                    },
                    child: Ink(
                      padding: theme.standardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Parola', style: theme.informationTextStyle),
                          SizedBox(height: theme.spacing.small),
                          Text(splitCode(state.session.id),
                              style: theme.titleTextStyle),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: theme.spacing.xxLarge),
                Expanded(
                    child: Center(
                  child: session.students.isEmpty
                      ? Text(
                          "Asteptam elevii...",
                          style: theme.titleTextStyle,
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      DeviceSize.screenHeight ~/ 300,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 2),
                          itemCount: 30,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  //TODO: remove player
                                },
                                child: Ink(
                                  child: Center(
                                      child: Text("Pietraru Robert $index")),
                                ),
                              ),
                            );
                          },
                        ),
                )),
              ]),
            );
          },
        ),
      ),
    );
  }
}
