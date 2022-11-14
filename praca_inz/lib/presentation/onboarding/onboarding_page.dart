import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/presentation/onboarding/cubit/onboarding_cubit.dart';

import '../../generated/local_keys.g.dart';
import '../common/custom_page_indicator.dart';
import '../routing/main_router.gr.dart';
import '../style/app_dimens.dart';
import '../style/app_themes.dart';

class OnboardingPage extends HookWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;

    final cubit = useBloc<OnboardingCubit>();
    final state = useBlocBuilder(cubit);

    useBlocListener<OnboardingCubit, OnboardingState>(
      cubit,
      (
        bloc,
        current,
        context,
      ) =>
          current.mapOrNull(
        display: (value) {},
        skip: (value) => context.router.replace(
          const LoginPageRoute(), //TODO change to main page
        ),
      ),
    );
    useEffect(
      () {
        cubit.displayOnboarding();
      },
      [cubit],
    );

    return Scaffold(
      backgroundColor: customTheme.background,
      body: state.maybeMap(
        display: (value) => _OnboardingPageBuilder(),
        orElse: () => Center(
          child: CircularProgressIndicator(
            color: customTheme.primary100,
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageBuilder extends HookWidget {
  _OnboardingPageBuilder({Key? key}) : super(key: key);

  final List<Widget> onboardingList = <Widget>[
    _OnboardingPageBody(
      iconContent: Icons.local_movies,
      isLastPage: false,
      title: LocaleKeys.onboarding_titles_Explore.tr(),
      subtitle: LocaleKeys.onboarding_subtitles_Explore.tr(),
    ),
    _OnboardingPageBody(
      iconContent: Icons.local_movies,
      isLastPage: false,
      title: LocaleKeys.onboarding_titles_WhatsPopular.tr(),
      subtitle: LocaleKeys.onboarding_subtitles_WhatsPopular.tr(),
    ),
    _OnboardingPageBody(
      iconContent: Icons.local_movies,
      isLastPage: false,
      title: LocaleKeys.onboarding_titles_Watchlist.tr(),
      subtitle: LocaleKeys.onboarding_subtitles_Watchlist.tr(),
    ),
    _OnboardingPageBody(
      iconContent: Icons.local_movies, //jakas ikona oceny gwiazdka czy cos
      isLastPage: true,
      title: LocaleKeys.onboarding_titles_Vote.tr(),
      subtitle: LocaleKeys.onboarding_subtitles_Vote.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;
    final controller = usePageController();
    final onboardingLength = onboardingList.length;

    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: onboardingLength,
            itemBuilder: (context, index) => onboardingList[index],
          ),
          Positioned(
            width: AppDimens.xxc,
            bottom: AppDimens.xxxxc,
            child: SizedBox(
              height: AppDimens.m,
              child: CustomPageIndicator(
                controller: controller,
                activeColor: customTheme.primary100,
                count: onboardingLength,
                inactiveColor: customTheme.primary10,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: GestureDetector(
              onTap: () => context.router.replace(const LoginPageRoute()), //TODO change to main page
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.l,
                  left: AppDimens.l,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.close),
                    Text(
                      ' ${LocaleKeys.onboarding_skip.tr()}',
                      style: customTheme.style4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageBody extends StatelessWidget {
  const _OnboardingPageBody({
    required this.title,
    required this.subtitle,
    required this.isLastPage,
    required this.iconContent,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isLastPage;
  final IconData iconContent;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconContent),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimens.sm,
                top: AppDimens.m,
              ),
              child: Text(
                title,
                style: customTheme.style1,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.xl,
              ),
              child: Text(
                subtitle,
                style: customTheme.style7,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Visibility(
          visible: isLastPage,
          child: Positioned(
            bottom: AppDimens.ml,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - AppDimens.c,
              height: AppDimens.c,
              child: TextButton(
                onPressed: () => context.router.replace(const LoginPageRoute()), //TODO change to main page
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(customTheme.primary100),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.sm),
                    ),
                  ),
                ),
                child: Text(
                  LocaleKeys.onboarding_GotIt.tr(),
                  style: customTheme.style4.copyWith(
                    color: customTheme.buttonMain,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
