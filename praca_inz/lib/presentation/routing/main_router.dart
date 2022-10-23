import 'package:auto_route/auto_route.dart';

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
  ],
)
class $MainRouter {}
