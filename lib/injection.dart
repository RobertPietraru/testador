import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:testador/features/test/test_injector.dart';
import 'package:testador/flavours/build_environment.dart';
import 'features/authentication/auth_injector.dart';
import 'firebase_options.dart';

GetIt locator = GetIt.instance;

Future<void> inject() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  locator.registerSingleton<BuildEnvironment>(
      BuildEnvironment(flavour: BuildFlavour.development));

  authInject();
  quizInject();
}
