import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/main.dart';
import 'package:praca_inzynierska/presentation/single_movie/cubit/movie_details_cubit.dart';
import 'package:praca_inzynierska/presentation/style/app_colors.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_icons.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class SingleMovieDetailsPage extends HookWidget {
  const SingleMovieDetailsPage({
    required this.movieTitle,
    Key? key,
  }) : super(key: key);

  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<MovieDetailsCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return state.maybeMap(
      error: (value) => Center(
        child: Text(
          value.error,
          style: const TextStyle(color: AppColors.error100),
        ),
      ),
      orElse: () {
        cubit.getMovieDetails(movieTitle);

        return const Center(child: CircularProgressIndicator());
      },
      idle: (value) => MovieDetailsPageBody(movie: value.movieDetails.first),
    );
  }
}

class MovieDetailsPageBody extends StatelessWidget {
  const MovieDetailsPageBody({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;

    return Scaffold(
        backgroundColor: customTheme.background,
        body: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: movie.poster,
                  fit: BoxFit.fitWidth,
                  errorWidget: (
                    context,
                    url,
                    error,
                  ) =>
                      SvgPicture.asset(AppIcon.noCover),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                height: 0.8 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      customTheme.background,
                      customTheme.background,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.ml,
                    right: AppDimens.ml,
                    top: AppDimens.xl,
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 0.2 * MediaQuery.of(context).size.height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppDimens.l),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _RoundButton(
                              customTheme: customTheme,
                              iconWidget: SvgPicture.asset(AppIcon.emptyHeart),
                              iconFilledWidget:
                                  SvgPicture.asset(AppIcon.filledHeart),
                            ),
                            _RoundButton(
                              customTheme: customTheme,
                              iconWidget:
                                  const Icon(Icons.watch_later_outlined),
                              iconFilledWidget:
                                  const Icon(Icons.watch_later_rounded),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        movie.title,
                        style: customTheme.style2.copyWith(fontSize: 26),
                      ),
                      Text(
                        movie.genre,
                        style: customTheme.style7,
                      ),
                      CustomDivider(customTheme: customTheme),
                      Text(
                        movie.plot,
                        style: customTheme.style7,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppDimens.sm,
              top: AppDimens.l,
              child: BackButton(
                color: customTheme.element,
              ),
            ),
          ],
        ));
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    required this.customTheme,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.s),
      child: Container(
        color: customTheme.divider,
        height: AppDimens.one,
        width: double.infinity,
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.customTheme,
    required this.iconWidget,
    required this.iconFilledWidget,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;
  final Widget iconWidget;
  final Widget iconFilledWidget;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: customTheme.primary10,
        padding: const EdgeInsets.all(AppDimens.m),
      ),
      child: iconWidget,
    );
  }
}
