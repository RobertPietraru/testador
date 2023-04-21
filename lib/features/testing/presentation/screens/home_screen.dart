import 'package:flutter/material.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/theme/app_theme.dart';

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
        onPressed: () {},
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
              Tab(text: 'Creeate'),
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
                  return const RoundedImageWidget(
                      imageUrl:
                          'https://img.freepik.com/premium-vector/job-exam-test-vector-illustration_138676-243.jpg',
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

class RoundedImageWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double width;
  final double height;

  const RoundedImageWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      this.width = 300,
      this.height = 300});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return GestureDetector(
      onSecondaryTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(onPressed: () {}, child: Text('asddf')),
                    TextButton(onPressed: () {}, child: Text('asddf')),
                  ],
                ));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(actions: [
            TextButton(onPressed: () {}, child: Text('asddf')),
            TextButton(onPressed: () {}, child: Text('asddf')),
          ]),
        );
      },
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
