import 'package:auto_route/auto_route.dart';
import 'package:praca_inzynierska/presentation/authorization/authorization_page.dart';

import '../login/login_page.dart';
import '../onboarding/onboarding_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      page: OnboardingPage,
      initial: true,
    ),
    AutoRoute(
      page: LoginPage,
      initial: true,
    ),
    AutoRoute(
      page: AuthorizationPage,
      initial: true,
    ),
  ],
)
class $MainRouter {}
