import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_icons.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class HorizontalMovieScroll extends StatelessWidget {
  const HorizontalMovieScroll({
    required this.movies,
    required this.title,
    required this.onCoverTap,
    Key? key,
  }) : super(key: key);

  final List<Movie> movies;
  final VoidCallback onCoverTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.customAppTheme;
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
              itemCount: movies.length,
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
                      onTap: onCoverTap,
                      child: CachedNetworkImage(
                        imageUrl: movies[index].poster,
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
                                  movies[index].title,
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
  }
}
