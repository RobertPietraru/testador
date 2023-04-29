import 'package:auto_route/auto_route.dart';
import 'package:testador/core/routing/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final bool isAuthenticated;

  AuthGuard({required this.isAuthenticated});
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    if (isAuthenticated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(const RegistrationRoute());
    }
  }
}
