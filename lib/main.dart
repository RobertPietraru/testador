import 'package:flutter/material.dart';
import 'package:testador/flavours/build_environment.dart';
import 'package:testador/flavours/main_development.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final BuildEnvironment environment =
      BuildEnvironment(flavour: BuildFlavour.development);

  if (environment.flavour == BuildFlavour.development) {
    mainDevelopment();
  }
}
