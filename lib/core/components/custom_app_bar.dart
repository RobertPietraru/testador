import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/services.dart';
import 'package:testador/core/components/components.dart';
import 'package:testador/core/routing/app_router.gr.dart';

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
    required BuildContext context,
  }) {
    final translator = AppLocalizations.of(context);

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
          [
            TextButton(
                onPressed: () {
                  if (DeviceSize.isDesktopMode) {
                    context.navigateTo(const PlayerSessionManagerRoute());
                  } else {
                    context.pushRoute(const PlayerSessionManagerRoute());
                  }
                },
                child: Text(translator.play, style: theme.actionTextStyle)),
            SizedBox(width: theme.spacing.small),
            IconButton(onPressed: () {}, icon: const Icon(Icons.language))
          ],
      bottom: bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return theAppBar(
      theme: theme,
      onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
      context: context,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
