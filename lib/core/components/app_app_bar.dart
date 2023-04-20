import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/app_theme_data.dart';

import 'app_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? leading;
  final List<Widget>? trailing;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    Key? key,
    this.showLeading = true,
    this.leading,
    this.trailing,
    this.title,
    this.bottom,
  }) : super(key: key);

  AppBar theAppBar({
    required AppThemeData theme,
  }) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      automaticallyImplyLeading: showLeading && leading == null,
      leading: leading,
      centerTitle: true,
      title: title ?? AppLogo(color: theme.primaryColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: trailing,
      bottom: bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return theAppBar(theme: theme);
  }

  @override
  Size get preferredSize => theAppBar(theme: LightAppThemeData()).preferredSize;
}
