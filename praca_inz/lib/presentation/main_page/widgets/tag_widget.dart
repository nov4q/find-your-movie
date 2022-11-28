import 'package:flutter/material.dart';
import 'package:praca_inzynierska/presentation/main_page/widgets/tag_map.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';
import '../../style/app_dimens.dart';

class TagWidget extends StatelessWidget {
  TagWidget({
    required this.customTheme,
    required this.title,
    Key? key,
  }) : super(key: key);
  final CustomAppTheme customTheme;
  final String title;
  final emotes = TagMap.tagObjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimens.l),
            child: Text(
              title,
              style: customTheme.style4.copyWith(
                color: customTheme.main,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.m),
          SizedBox(
            height: AppDimens.xxl,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: emotes.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const VerticalDivider(
                      color: Colors.transparent,
                      width: AppDimens.s,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  final key = emotes.keys.elementAt(index);
                  return TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(AppDimens.ten)),
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            customTheme.buttonMain),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppDimens.xs)))),
                    onPressed: () {},
                    // context.router.push(TagPageRoute(tagName: key)),
                    child: Row(children: [
                      Text(
                        '$key  ',
                        style: customTheme.style10,
                      ),
                      Image.asset("${emotes[key]}"),
                    ]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
