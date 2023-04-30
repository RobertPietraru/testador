import 'package:flutter/material.dart';
import 'package:testador/core/components/theme/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Drawer(
      child: Column(children: [
        ListTile(
            onTap: () {}, title: Text("Contact", style: theme.actionTextStyle)),
        ListTile(
            onTap: () {},
            title: Text("Descopera", style: theme.actionTextStyle)),
        ListTile(
            onTap: () {},
            title: Text("Alatura-te", style: theme.actionTextStyle)),
        ListTile(
            onTap: () {}, title: Text("Creeaza", style: theme.actionTextStyle)),
      ]),
    );
  }
}
