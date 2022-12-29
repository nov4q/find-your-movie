import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/generated/local_keys.g.dart';
import 'package:praca_inzynierska/presentation/routing/main_router.gr.dart';
import 'package:praca_inzynierska/presentation/search/cubit/search_cubit.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/presentation/style/app_icons.dart';
import 'package:praca_inzynierska/presentation/style/app_themes.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;

    final textfieldController = useTextEditingController();
    final cubit = useBloc<SearchCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customTheme.primary90,
        title: Container(
          height: 40,
          color: Colors.white,
          child: Center(
            child: TextField(
              controller: textfieldController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    textfieldController.clear();
                    cubit.clearResults();
                  },
                  icon: const Icon(Icons.clear),
                ),
                hintText: LocaleKeys.search_SearchField.tr(),
                hintStyle: TextStyle(color: customTheme.main),
                border: InputBorder.none,
              ),
              onChanged: (query) => cubit.searchMovie(query),
              onEditingComplete: () =>
                  cubit.searchMovie(textfieldController.value.text),
            ),
          ),
        ),
      ),
      body: state.maybeMap(
        searchResults: (value) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: customTheme.divider),
            itemCount: value.results.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateToMovieDetailsPage(
                  context: context,
                  title: value.results[index].title,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.sm),
                  color: customTheme.background,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: AppDimens.sm),
                      SizedBox(
                        height: AppDimens.g,
                        width: AppDimens.d,
                        child: CachedNetworkImage(
                          imageUrl: value.results[index].poster,
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
                                    value.results[index].title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimens.m),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppDimens.l),
                          child: Text(
                            value.results[index].title,
                            style: customTheme.style2.copyWith(fontSize: 20),
                            softWrap: false,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void navigateToMovieDetailsPage({
    required BuildContext context,
    required String title,
  }) =>
      context.router.push(SingleMovieDetailsPageRoute(movieTitle: title));
}
