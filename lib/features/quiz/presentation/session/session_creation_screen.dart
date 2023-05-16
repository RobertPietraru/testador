import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';

import '../../../../core/components/theme/app_theme.dart';
import '../../../../core/components/theme/device_size.dart';

class QuizSessionCreationScreen extends StatelessWidget {
  const QuizSessionCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final bool hasStudents = true;
    return Scaffold(
      appBar: CustomAppBar(
        trailing: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      hasStudents ? theme.good : theme.secondaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: hasStudents ? () {} : null,
              child: const Text('Salveaza'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: theme.standardPadding,
        child: Column(children: [
          Text(
            "Se creaza acum sesiunea ta de joc",
            style: theme.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: theme.spacing.large),
          Card(
            elevation: 25,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Ink(
                padding: theme.standardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Parola', style: theme.informationTextStyle),
                    SizedBox(height: theme.spacing.small),
                    Text("123 8123", style: theme.titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: theme.spacing.xxLarge),
          Expanded(
              child: Center(
            child: !hasStudents
                ? Text(
                    "Asteptam elevii...",
                    style: theme.titleTextStyle,
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: DeviceSize.screenHeight ~/ 300,
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
                            child:
                                Center(child: Text("Pietraru Robert $index")),
                          ),
                        ),
                      );
                    },
                  ),
          )),
        ]),
      ),
    );
  }
}
