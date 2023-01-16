import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
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
      idle: (value) => MovieDetailsPageBody(
        movie: value.movieDetails.first,
        cubit: cubit,
      ),
    );
  }
}

class MovieDetailsPageBody extends StatelessWidget {
  const MovieDetailsPageBody({
    required this.movie,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final MovieDetailsCubit cubit;
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _RoundButton(
                                  toastText:
                                      "Pomyślnie dodano do Twojej kolekcji ulubionych filmów",
                                  onPressed: cubit.addToFavourites,
                                  customTheme: customTheme,
                                  iconWidget:
                                      SvgPicture.asset(AppIcon.filledHeart),
                                  iconFilledWidget:
                                      SvgPicture.asset(AppIcon.filledHeart),
                                ),
                                _RoundButton(
                                  toastText:
                                      "Pomyślnie dodano do Twojej kolekcji zawierającej listę filmów do zobaczenia później",
                                  onPressed: cubit.addToUserWatchlist,
                                  customTheme: customTheme,
                                  iconWidget:
                                      const Icon(Icons.watch_later_rounded),
                                  iconFilledWidget:
                                      const Icon(Icons.watch_later_rounded),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppDimens.m,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _RoundButton(
                                  toastText:
                                      "Pomyślnie usunięto film z Twojej kolekcji ulubionych filmów",
                                  onPressed: cubit.deleteFromFavourites,
                                  customTheme: customTheme,
                                  iconWidget:
                                      SvgPicture.asset(AppIcon.emptyHeart),
                                  iconFilledWidget:
                                      SvgPicture.asset(AppIcon.emptyHeart),
                                ),
                                _RoundButton(
                                  toastText:
                                      "Pomyślnie usunięto film z Twojej kolekcji filmów do zobaczenia w przyszłości",
                                  onPressed: cubit.deleteFromWatchlist,
                                  customTheme: customTheme,
                                  iconWidget:
                                      const Icon(Icons.watch_later_outlined),
                                  iconFilledWidget:
                                      const Icon(Icons.watch_later_outlined),
                                ),
                              ],
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
                      Text(
                        movie.year,
                        style: customTheme.style7,
                      ),
                      CustomDivider(customTheme: customTheme),
                      Text(
                        movie.plot,
                        style: customTheme.style7,
                      ),
                      CustomDivider(
                        customTheme: customTheme,
                        visible: false,
                      ),
                      Text(
                        "Obsada\n${movie.actors}",
                        style: customTheme.style7,
                      ),
                      CustomDivider(
                        customTheme: customTheme,
                        visible: false,
                      ),
                      Text(
                        "Reyżser\n${movie.director}",
                        style: customTheme.style7,
                      ),
                      CustomDivider(
                        customTheme: customTheme,
                        visible: false,
                      ),
                      Text(
                        "Nagrody\n${movie.awards}",
                        style: customTheme.style7,
                      ),
                      CustomDivider(
                        customTheme: customTheme,
                        visible: true,
                      ),
                      Text(
                        "Żródło plakatu\n${movie.poster}",
                        maxLines: 5,
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
    this.visible = true,
    Key? key,
  }) : super(key: key);

  final CustomAppTheme customTheme;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.s),
      child: Container(
        color: visible ? customTheme.divider : Colors.transparent,
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
    required this.onPressed,
    Key? key,
    this.toastText,
  }) : super(key: key);
  final VoidCallback onPressed;
  final CustomAppTheme customTheme;
  final Widget iconWidget;
  final Widget iconFilledWidget;
  final String? toastText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
        if ((toastText?.isNotEmpty) ?? false) {
          final snackBar = SnackBar(content: Text(toastText!));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: customTheme.primary10,
        padding: const EdgeInsets.all(AppDimens.m),
      ),
      child: iconWidget,
    );
  }
}
