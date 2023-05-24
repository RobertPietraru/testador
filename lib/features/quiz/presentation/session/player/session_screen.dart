import 'package:flutter/material.dart';
import 'package:testador/core/components/custom_app_bar.dart';
import 'package:testador/features/quiz/domain/entities/session/session_entity.dart';

class SessionScreen extends StatelessWidget {
  final SessionEntity session;
  const SessionScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('session')),
    );
  }
}
