import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';
import 'package:praca_inzynierska/presentation/routing/main_router.gr.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_icons.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class HorizontalMovieScroll extends StatelessWidget {
  const HorizontalMovieScroll({
    required this.title,
    required this.movies,
    this.isUserCollection = false,
    this.unAuthenticated = false,
    Key? key,
  }) : super(key: key);

  final List<MovieRepresentation>? movies;
  final String title;
  final bool isUserCollection;
  final bool unAuthenticated;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.customAppTheme;
    if ((movies?.isNotEmpty) ?? false) {
      return Padding(
        padding: const EdgeInsets.only(top: AppDimens.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: appTheme.style4,
            ),
            const SizedBox(height: AppDimens.six),
            SizedBox(
              height: AppDimens.g,
              child: ListView.separated(
                itemCount: movies!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const VerticalDivider(
                  color: Colors.transparent,
                  width: AppDimens.s,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: SizedBox(
                      height: AppDimens.g,
                      width: AppDimens.d,
                      child: GestureDetector(
                        onTap: () {
                          if (!unAuthenticated) {
                            navigateToMovieDetailsPage(
                              context: context,
                              title: movies![index].title,
                            );
                          }
                        },
                        child: CachedNetworkImage(
                          imageUrl: movies![index].poster,
                          fit: BoxFit.cover,
                          errorWidget: (
                            context,
                            url,
                            error,
                          ) =>
                              Stack(
                            children: [
                              SvgPicture.asset(AppIcon.noCover),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(AppDimens.ten),
                                  child: Text(
                                    movies![index].title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: AppDimens.m),
        child: Text(
          isUserCollection
              ? "Dodaj swoje filmy do kolekcji ${title.toLowerCase()}"
              : "Wystąpił problem z kolekcją $title",
          textAlign: TextAlign.center,
          style: appTheme.style4,
        ),
      );
    }
  }

  void navigateToMovieDetailsPage({
    required BuildContext context,
    required String title,
  }) =>
      context.router.push(SingleMovieDetailsPageRoute(movieTitle: title));
}
