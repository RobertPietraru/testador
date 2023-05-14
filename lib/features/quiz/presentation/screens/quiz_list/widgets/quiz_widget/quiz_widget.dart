import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/quiz/domain/entities/draft_entity.dart';
import 'package:testador/features/quiz/domain/entities/quiz_entity.dart';

import '../../../../../../../core/components/theme/app_theme.dart';
import '../../../../../../../core/routing/app_router.gr.dart';
import '../../cubit/quiz_list_cubit.dart';

class QuizWidget extends StatelessWidget {
  final double width;
  final double height;
  final QuizEntity quiz;
  final DraftEntity? draft;

  const QuizWidget(
      {super.key,
      this.width = 300,
      this.height = 300,
      required this.quiz,
      this.draft});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Builder(builder: (context) {
      return GestureDetector(
        onLongPress: () {},
        onTap: () {
          context.pushRoute(
            QuizRoute(
              quizId: quiz.id,
              quiz: quiz,
              draft: draft,
              quizListCubit: context.read<QuizListCubit>(),
            ),
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.blue,
          elevation: 30,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(quiz.imageUrl ?? theme.placeholderImage),
                  opacity: 0.5,
                  fit: BoxFit.cover,
                ),
                color: theme.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: theme.standardPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          quiz.title ?? 'Fara titlu',
                          textAlign: TextAlign.left,
                          style: theme.titleTextStyle
                              .copyWith(color: theme.defaultBackgroundColor),
                        ),
                      ),
                      if (hasToSync())
                        Container(
                            height: 40,
                            padding: theme.standardPadding
                                .copyWith(top: 0, bottom: 0),
                            decoration: BoxDecoration(
                                color: theme.bad,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "Nesalvat",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                    ],
                  ),
                ),
                Container(
                    padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: theme.defaultBackgroundColor),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "100 elevi",
                            style: theme.informationTextStyle,
                          ),
                          quiz.isPublic
                              ? Icon(
                                  Icons.public,
                                  color: theme.good,
                                )
                              : Icon(
                                  Icons.public_off,
                                  color: theme.bad,
                                )
                        ]))
              ],
            ),
          ),
        ),
      );
    });
  }

  bool hasToSync() {
    if (draft == null) return false;
    return quiz != draft?.toQuiz();
  }
}
