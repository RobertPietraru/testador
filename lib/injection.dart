import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:testador/features/quiz/quiz_injector.dart';
import 'features/authentication/auth_injector.dart';
import 'firebase_options.dart';

GetIt locator = GetIt.instance;

Future<void> initialize() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  authInject();
  quizInject();
}
