import 'package:auto_route/auto_route.dart';
import 'package:praca_inzynierska/presentation/authorization/authorization_page.dart';
import 'package:praca_inzynierska/presentation/main_page/main_page.dart';
import 'package:praca_inzynierska/presentation/search/search_page.dart';
import 'package:praca_inzynierska/presentation/single_movie/single_movie_page.dart';

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
      initial: false,
    ),
    AutoRoute(
      page: AuthorizationPage,
      initial: false,
    ),
    AutoRoute(
      page: MainPage,
      initial: true,
    ),
    AutoRoute(
      page: SingleMovieDetailsPage,
      initial: false,
    ),
    AutoRoute(
      page: SearchPage,
      initial: false,
    ),
  ],
)
class $MainRouter {}
