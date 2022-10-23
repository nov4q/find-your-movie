import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_form_state.dart';
part 'login_form_cubit.freezed.dart';

@Injectable()
class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormState.initial());

  String _cachedLogin = '';
  String _cachedPassword = '';
  bool _isPasswordObscure = true;
  bool _loginError = false;

  void init() {
    _emitIdle();
  }

  void setCachedPassword(String value) {
    _cachedPassword = value;
    _emitIdle();
  }

  void setCachedLogin(String value) {
    _cachedLogin = value;
    _emitIdle();
  }

  void setPasswordObscurity() {
    _isPasswordObscure = !_isPasswordObscure;
    _emitIdle();
  }

  bool get _isFormFilled =>
      _cachedLogin.isNotEmpty && _cachedPassword.isNotEmpty;

  void _emitIdle() => emit(
        LoginFormState.idle(
          isPasswordObscure: _isPasswordObscure,
          isFormFilled: _isFormFilled,
          loginError: _loginError,
        ),
      );
}
