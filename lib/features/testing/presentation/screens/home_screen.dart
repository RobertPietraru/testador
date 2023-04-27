import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/core/components/theme/device_size.dart';
import 'package:testador/core/routing/app_router.dart';

import '../../../../core/components/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const name = "Bob";
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.companyColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const TestTypeSelectionDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: theme.standardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bine ai venit, $name", style: theme.titleTextStyle),
            SizedBox(height: theme.spacing.small),
            Text("Testele tale", style: theme.subtitleTextStyle),
            SizedBox(height: theme.spacing.mediumLarge),
            TabBar(controller: controller, tabs: const [
              Tab(text: 'Create'),
              Tab(text: 'Neterminate'),
            ]),
            SizedBox(height: theme.spacing.mediumLarge),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return TestWidget(
                      onPressed: () {
                        context.pushRoute(TestAdminRoute(testId: 'my-id'));
                      },
                      onSelect: () {},
                      imageUrl:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                      label:
                          'Evaluare Nationala la Limba si Literatura Romana');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double width;
  final double height;
  final VoidCallback onSelect;
  final VoidCallback onPressed;

  const TestWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      this.width = 300,
      this.height = 300,
      required this.onSelect,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return GestureDetector(
      onLongPress: onSelect,
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black.withOpacity(0.7),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: theme.informationTextStyle,
              ),
            ),
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
          gradient: const LinearGradient(colors: [
            Color(0xFF000AFF),
            Color(0xFFFF005A),
          ]),
        ),
        SizedBox(height: theme.spacing.medium),
        SelectionOptionWidget(
          onPressed: () {},
          title: "Creeare personalizata",
          description:
              "Creeati testul avand control absolut asupra structurii, intrebarilor, etc",
          gradient: const LinearGradient(colors: [
            Color(0xFF0061ff),
            Color(0xFF60efff),
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
        height: 130,
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
              Text(widget.description, style: const TextStyle(fontSize: 15)),
            ]),
      ),
    );
  }
}
