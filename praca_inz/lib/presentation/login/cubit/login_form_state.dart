part of 'login_form_cubit.dart';

@freezed
class LoginFormState with _$LoginFormState {
  @Implements<BuildState>()
  const factory LoginFormState.initial() = _Idle;
  const factory LoginFormState.idle({
    required bool isPasswordObscure,
    required bool isFormFilled,
    required bool loginError,
  }) = _Initial;
}
