import 'package:flutter/material.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class HorizontalMovieScroll extends StatelessWidget {
  const HorizontalMovieScroll({
    required this.movies,
    required this.title,
    Key? key,
  }) : super(key: key);

  final List movies;
  final String title;
  @override
  Widget build(BuildContext context) {
    final appTheme = context.customAppTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appTheme.style4,
        ),
        SizedBox(
          height: AppDimens.xxc,
          child: ListView.separated(
            itemCount: 20,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: AppDimens.s,
            ),
            itemBuilder: (context, index) {
              return Text('data');
            },
          ),
        ),
      ],
    );
  }
}