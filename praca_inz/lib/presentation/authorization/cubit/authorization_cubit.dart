import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/use_case/authorization/auth_use_case.dart';

part 'authorization_state.dart';
part 'authorization_cubit.freezed.dart';

@injectable
class AuthorizationCubit extends Cubit<AuthorizationState> {
  final AuthUseCase _authUseCase;
  AuthorizationCubit(this._authUseCase)
      : super(const AuthorizationState.unAuthenticated());

  Future<void> signInRequested(String email, String password) async {
    emit(const _Loading());
    try {
      await _authUseCase.signInUseCase(
        email,
        password,
      );

      emit(const _Authenticated());
    } catch (e) {
      emit(_AuthError(e.toString()));
      emit(const _UnAuthenticated());
    }
  }

  Future<void> signUpRequested(String email, String password) async {
    emit(const _Loading());
    try {
      await _authUseCase.signUpUseCase(
        email,
        password,
      );
      emit(const _Authenticated());
    } catch (e) {
      emit(_AuthError(e.toString()));
      emit(const _UnAuthenticated());
    }
  }

  Future<void> googleSignInRequested() async {
    emit(const _Loading());
    try {
      await _authUseCase.signInWithGoogleUseCase();
      emit(const _Authenticated());
    } catch (e) {
      emit(_AuthError(e.toString()));
      emit(const _UnAuthenticated());
    }
  }

  Future<void> signOutRequested() async {
    emit(const _Loading());
    await _authUseCase.signOutUseCase();
    emit(const _UnAuthenticated());
  }
}
