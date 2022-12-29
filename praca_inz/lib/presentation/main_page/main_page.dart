import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/presentation/authorization/cubit/authorization_cubit.dart';
import 'package:praca_inzynierska/presentation/common/side_drawer.dart';
import 'package:praca_inzynierska/presentation/main_page/cubit/main_page_cubit.dart';
import 'package:praca_inzynierska/presentation/main_page/widgets/horizontal_movie_scroll.dart';
import 'package:praca_inzynierska/presentation/routing/main_router.gr.dart';
import 'package:praca_inzynierska/presentation/single_movie/single_movie_page.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class MainPage extends HookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;
    final cubit = useBloc<AuthorizationCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return state.maybeMap(
      authenticated: (state) {
        return _AuthenticatedBody(
          onLogout: cubit.signOutRequested,
          customTheme: customTheme,
          username: state.username,
        );
      },
      orElse: () {
        return Scaffold(
          backgroundColor: customTheme.background,
          drawer: SideDrawer(
            customTheme: customTheme,
            authenticated: false,
            name: '',
            onLoginTileTap: () => cubit.googleSignInRequested(),
          ),
          appBar: AppBar(
            backgroundColor: customTheme.primary90,
          ),
          body: SafeArea(
            child: _UnAuthenticatedBody(
              customTheme: customTheme,
            ),
          ),
        );
      },
    );
  }
}

class _UnAuthenticatedBody extends HookWidget {
  const _UnAuthenticatedBody({
    required this.customTheme,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;

  @override
  Widget build(BuildContext context) {
    final movieCubit = useBloc<MainPageCubit>();
    final movieState = useBlocBuilder(movieCubit);

    useEffect(
      () {
        movieCubit.initUnauthenticated();
      },
      [movieCubit],
    );

    return movieState.maybeMap(
      orElse: () => Center(
        child: CircularProgressIndicator(
          color: customTheme.primary100,
        ),
      ),
      unAuthenticated: (value) => SafeArea(
        child: Column(
          children: [
            HorizontalMovieScroll(
              movies: movieState.mapOrNull(
                unAuthenticated: (value) => value.topRatedMoviesList,
              ),
              unAuthenticated: true,
              title: 'Przykładowe filmy',
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.sm),
              child: CustomDivider(customTheme: customTheme),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.sm),
              child: Text(
                'Jeśli chcesz w pełni uzywać aplikacji i zobaczyć pełną listę filmów,',
                textAlign: TextAlign.center,
                style: customTheme.style6,
                maxLines: 4,
              ),
            ),
            const SizedBox(
              height: AppDimens.sm,
            ),
            Text(
              'zaloguj się juz teraz!',
              style: customTheme.style6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthenticatedBody extends HookWidget {
  const _AuthenticatedBody({
    required this.onLogout,
    required this.username,
    required this.customTheme,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;
  final String username;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final movieCubit = useBloc<MainPageCubit>();
    final movieState = useBlocBuilder(movieCubit);

    useEffect(
      () {
        movieCubit.init();
      },
      [movieCubit],
    );

    return Scaffold(
      backgroundColor: customTheme.background,
      drawer: SideDrawer(
        customTheme: customTheme,
        authenticated: true,
        name: username,
        onLoginTileTap: () => onLogout(),
      ),
      appBar: AppBar(
        backgroundColor: customTheme.primary90,
        actions: [
          GestureDetector(
            onTap: () => context.router.push(const SearchPageRoute()),
            child: const Padding(
              padding: EdgeInsets.only(
                right: AppDimens.ten,
              ),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: movieState.maybeMap(
        orElse: () => Center(
          child: CircularProgressIndicator(
            color: customTheme.primary100,
          ),
        ),
        idle: (value) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: AppDimens.l),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HorizontalMovieScroll(
                    movies: movieState.mapOrNull(
                      idle: (value) => value.popularMoviesList,
                    ),
                    title: 'Popularne',
                  ),
                  HorizontalMovieScroll(
                    movies: movieState.mapOrNull(
                      idle: (value) => value.topRatedMoviesList,
                    ),
                    title: 'Najlepiej ocenianie',
                  ),
                  HorizontalMovieScroll(
                    movies: movieState.mapOrNull(
                      idle: (value) => value.favouriteMoviesList,
                    ),
                    isUserCollection: true,
                    title: 'Ulubione',
                  ),
                  HorizontalMovieScroll(
                    movies: movieState.mapOrNull(
                      idle: (value) => value.userWatchlist,
                    ),
                    isUserCollection: true,
                    title: 'Lista do obejrzenia',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
