import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/presentation/authorization/cubit/authorization_cubit.dart';
import 'package:praca_inzynierska/presentation/common/side_drawer.dart';
import 'package:praca_inzynierska/presentation/main_page/cubit/main_page_cubit.dart';
import 'package:praca_inzynierska/presentation/main_page/widgets/horizontal_movie_scroll.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(left: AppDimens.l),
              child: Text(
                'unAuthenticated',
                style: customTheme.style10.copyWith(
                  color: customTheme.error100,
                ),
              ),
            ),
          ),
        );
      },
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
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(
                right: AppDimens.ten,
              ),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalMovieScroll(
                movies: movieState.maybeMap(
                  idle: (value) => value.topRatedMoviesList,
                  orElse: () => [],
                ),
                title: 'Najlepiej ocenianie',
              ),
              HorizontalMovieScroll(
                movies: movieState.maybeMap(
                  idle: (value) => value.favouriteMoviesList,
                  orElse: () => [],
                ),
                title: 'Ulubione',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
