import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../style/app_dimens.dart';
import '../../style/app_themes.dart';

class CustomTextInputField extends HookWidget {
  const CustomTextInputField({
    required this.labelText,
    this.onInputChanged,
    this.obscure = false,
    this.isError = false,
    this.isPassword = false,
    this.onSuffixIcon,
    this.errorLabel,
    Key? key,
  }) : super(key: key);

  final String labelText;
  final void Function(String)? onInputChanged;
  final bool obscure;
  final bool isError;
  final bool isPassword;
  final void Function()? onSuffixIcon;
  final String? errorLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomAppTheme>()!;

    final textController = useTextEditingController();

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: theme.element),
    );
    // UnderlineInputBorder(
    //   borderSide: BorderSide(color: theme.element),
    // );

    return TextFormField(
      controller: textController,
      onChanged: onInputChanged,
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: theme.style18.copyWith(
          color: isError ? theme.error100 : theme.main,
        ),
        border: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: theme.primary30,
          ),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: theme.error30,
          ),
        ),
        focusedErrorBorder: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        errorStyle: theme.style18.copyWith(color: theme.error100),
        errorText: errorLabel,
        errorMaxLines: 2,
        labelText: labelText,
        labelStyle: theme.style18.copyWith(color: theme.main),
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onSuffixIcon,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.sm),
                  child: Icon(
                    Icons.visibility_off_outlined,
                    color: theme.main,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      obscureText: obscure,
    );
  }
}
