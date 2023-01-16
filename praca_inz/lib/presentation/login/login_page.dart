import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:praca_inzynierska/presentation/login/cubit/login_form_cubit.dart';
import 'package:praca_inzynierska/presentation/login/widget/text_input_field_widget.dart';
import 'package:praca_inzynierska/presentation/routing/main_router.gr.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';


import '../../generated/local_keys.g.dart';
import '../style/app_themes.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomAppTheme>()!;

    final cubit = useBloc<LoginFormCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return Scaffold(
      backgroundColor: customTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    context.router.push(const AuthorizationPageRoute()),
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
                  LocaleKeys.welcome_LoginBtn.tr(),
                  style: customTheme.style4.copyWith(
                    color: customTheme.buttonMain,
                  ),
                ),
              ),
              CustomTextInputField(
                labelText: LocaleKeys.welcome_Login.tr(),
                isError: state.maybeMap(
                  idle: (value) => value.loginError,
                  orElse: () => false,
                ),
                onInputChanged: (value) => cubit.setCachedLogin(value),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.xl),
                child: CustomTextInputField(
                  labelText: LocaleKeys.welcome_Password.tr(),
                  isPassword: true,
                  onSuffixIcon: () => cubit.setPasswordObscurity(),
                  onInputChanged: (value) => cubit.setCachedPassword(value),
                  obscure: state.maybeMap(
                    idle: (value) => value.isPasswordObscure,
                    orElse: () => false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.xl),
                child: SizedBox(
                  width: double.infinity,
                  height: AppDimens.c,
                  child: TextButton(
                    onPressed: () {},
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
                      LocaleKeys.welcome_LoginBtn.tr(),
                      style: customTheme.style4.copyWith(
                        color: customTheme.buttonMain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.l),
                child: Text(
                  LocaleKeys.welcome_NoAccount.tr(),
                  style: customTheme.style7,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
