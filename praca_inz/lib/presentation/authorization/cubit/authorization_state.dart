part of 'authorization_cubit.dart';

@freezed
class AuthorizationState with _$AuthorizationState {
  /// When the user presses the signin or signup button the state is changed to loading first and then to Authenticated.
  const factory AuthorizationState.loading() = _Loading;

  /// When the user is authenticated the state is changed to Authenticated.
  const factory AuthorizationState.authenticated({
    required String username,
  }) = _Authenticated;

  /// This is the initial state of the bloc. When the user is not authenticated the state is changed to Unauthenticated.
  const factory AuthorizationState.unAuthenticated() = _UnAuthenticated;

  /// If any error occurs the state is changed to AuthError.
  const factory AuthorizationState.authError(String error) = _AuthError;
}
