import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testador/core/components/custom_app_bar.dart';

@RoutePage()
class JoinSessionScreen extends StatelessWidget {
  const JoinSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('Join')),
    );
  }
}
