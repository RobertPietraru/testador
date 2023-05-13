import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';
import 'package:testador/core/components/theme/device_size.dart';

import 'app_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? leading;
  final List<Widget>? trailing;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final Color fillColor;
  final Color? mainColor;
  const CustomAppBar({
    Key? key,
    this.showLeading = true,
    this.leading,
    this.trailing,
    this.title,
    this.bottom,
    this.fillColor = Colors.transparent,
    this.mainColor,
  }) : super(key: key);

  AppBar theAppBar({
    required AppThemeData theme,
    VoidCallback? onMenuPressed,
  }) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: fillColor == Colors.transparent ? 0 : null,
      foregroundColor: mainColor ?? theme.primaryColor,
      automaticallyImplyLeading: showLeading && leading == null,
      leading: leading,
      title: title ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(color: mainColor ?? theme.primaryColor),
              const SizedBox(width: 10),
              Text(
                "Testador",
                style: TextStyle(
                  color: mainColor ?? theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      backgroundColor: fillColor,
      actions: trailing ??
          (DeviceSize.isDesktopMode
              ? [
                  TextButton(
                      onPressed: () {},
                      child: Text("Contact", style: theme.actionTextStyle)),
                  SizedBox(width: theme.spacing.large),
                  TextButton(
                      onPressed: () {},
                      child: Text("Descopera", style: theme.actionTextStyle)),
                  SizedBox(width: theme.spacing.large),
                  TextButton(
                      onPressed: () {},
                      child: Text("Alatura-te", style: theme.actionTextStyle)),
                  SizedBox(width: theme.spacing.large),
                  TextButton(
                      onPressed: () {},
                      child: Text("Creeaza", style: theme.actionTextStyle)),
                ]
              : [
                  IconButton(
                      onPressed: onMenuPressed,
                      icon: Icon(
                        Icons.menu,
                        color: mainColor ?? theme.primaryColor,
                      )),
                ]),
      bottom: bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return theAppBar(
      theme: theme,
      onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
