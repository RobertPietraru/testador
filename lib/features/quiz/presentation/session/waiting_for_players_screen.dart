import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/custom_app_bar.dart';
import 'package:testador/features/quiz/presentation/session/cubit/session_admin_cubit.dart';

import '../../../../core/components/theme/app_theme.dart';
import '../../../../core/components/theme/device_size.dart';

class WaitingForPlayersScreen extends StatelessWidget {
  final SessionAdminMatchState state;
  const WaitingForPlayersScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final session = state.session;
    return Scaffold(
      appBar: CustomAppBar(
        trailing: [
          appBarButton(
            //TODO: use this:state.session.students.isNotEmpty
            isEnabled: true,
            onPressed: () => context.read<SessionAdminCubit>().beginSession(),
            text: 'Incepe',
          )
        ],
      ),
      body: Padding(
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
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Copiat codul")));
                await Clipboard.setData(ClipboardData(text: state.session.id));
              },
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Copiat codul")));
                await Clipboard.setData(ClipboardData(text: state.session.id));
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
                ? Text("Asteptam elevii...", style: theme.titleTextStyle)
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
}


