import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/domain/authorization/auth_repository.dart';

@injectable
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<void> signInUseCase(String email, String password) async =>
      _authRepository.signIn(
        email: email,
        password: password,
      );

  Future<void> signInWithGoogleUseCase() async =>
      _authRepository.signInWithGoogle();

  Future<void> signOutUseCase() async => _authRepository.signOut();

  Future<void> signUpUseCase(String email, String password) async =>
      _authRepository.signUp(
        email: email,
        password: password,
      );
}
