import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/drawer.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/core/routing/app_router.gr.dart';

import '../../../../core/components/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const name = "Bob";
    final theme = AppTheme.of(context);
    return Scaffold(
        appBar: const CustomAppBar(),
        endDrawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.companyColor,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const TestTypeSelectionDialog(),
          ),
          child: const Icon(Icons.add),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bine ai venit,',
                          style: TextStyle(
                            color: theme.secondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: theme.spacing.large,
                          ),
                        ),
                        Text(
                          'Testele tale',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: theme.spacing.xxLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ];
          },
          body: DeviceSize.isDesktopMode
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (DeviceSize.screenHeight / 300).toInt(),
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: theme.standardPadding,
                    child: TestWidget(
                      onPressed: () {
                        context.pushRoute(TestAdminRoute(testId: 'my-id'));
                      },
                      onSelect: () {},
                      imageUrl:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                      label: 'Evaluare Nationala la Limba si Literatura Romana',
                      isPublished: true,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) => Padding(
                    padding: theme.standardPadding,
                    child: TestWidget(
                        isPublished: true,
                        onPressed: () =>
                            context.pushRoute(TestAdminRoute(testId: 'my-id')),
                        onSelect: () {},
                        imageUrl:
                            'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                        label:
                            'Evaluare Nationala la Limba si Literatura Romana'),
                  ),
                ),
        ));
  }
}

class TestWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double width;
  final double height;
  final VoidCallback onSelect;
  final VoidCallback onPressed;
  final bool isPublished;

  const TestWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      this.width = 300,
      this.height = 300,
      required this.onSelect,
      required this.onPressed,
      required this.isPublished});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return GestureDetector(
      onLongPress: onSelect,
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.blue,
        elevation: 30,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                opacity: 0.5,
                fit: BoxFit.cover,
              ),
              color: theme.primaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: theme.standardPadding,
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: theme.titleTextStyle
                      .copyWith(color: theme.defaultBackgroundColor),
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
                        isPublished
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
  }
}

class TestTypeSelectionDialog extends StatelessWidget {
  const TestTypeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomDialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cum preferi sa lucrezi?",
          style: theme.titleTextStyle,
        ),
        SizedBox(height: theme.spacing.xLarge),
        SelectionOptionWidget(
          onPressed: () {},
          title: "Creeare rapida",
          description: "Creati testul cu ajutorul unei structuri deja definite",
          gradient: const LinearGradient(colors: [
            Color(0xFF028cf3),
            Color(0xFF2feaa8),
          ]),
        ),
        SizedBox(height: theme.spacing.medium),
        SelectionOptionWidget(
          onPressed: () {},
          title: "Creeare cu A.I.",
          description:
              "Creati testul cu ajutorul inteligentei artificiale. Introduceti materia predata si programul genereaza testul",
          gradient: LinearGradient(colors: [
            const Color(0xFF0061ff).withOpacity(0.9),
            const Color(0xFFFF005A).withOpacity(0.9),
          ]),
        ),
        SizedBox(height: theme.spacing.medium),
        SelectionOptionWidget(
          onPressed: () {},
          title: "Creeare personalizata",
          description:
              "Creeati testul avand control absolut asupra structurii, intrebarilor, etc",
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 0, 200, 255),
            Color(0xFF0061ff),
          ]),
        ),
        SizedBox(height: theme.spacing.large),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Ai nevoie de ajutor? Contactati-ne la ",
              style: theme.actionTextStyle,
            ),
            TextSpan(
                text: "Centrul de ajutor",
                style:
                    theme.actionTextStyle.copyWith(color: theme.companyColor)),
          ]),
        )
      ],
    ));
  }
}

class SelectionOptionWidget extends StatefulWidget {
  const SelectionOptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.gradient,
    required this.onPressed,
  });

  final String title;
  final String description;
  final LinearGradient? gradient;
  final VoidCallback onPressed;

  @override
  State<SelectionOptionWidget> createState() => _SelectionOptionWidgetState();
}

class _SelectionOptionWidgetState extends State<SelectionOptionWidget> {
  bool isPressedOn = false;
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return GestureDetector(
      onTapDown: (details) => setState(() => isPressedOn = true),
      onTapUp: (details) => setState(() => isPressedOn = false),
      onTap: widget.onPressed,
      child: Container(
        height: DeviceSize.isDesktopMode ? 130 : null,
        width: 100.widthPercent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: widget.gradient?.scale(isPressedOn ? 0.8 : 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: theme.titleTextStyle),
              Text(widget.description,
                  style: theme.informationTextStyle
                      .copyWith(fontWeight: FontWeight.w500)),
            ]),
      ),
    );
  }
}
