import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

abstract class AuthRepository {
  final MovieFromMovieDtoMapper _mapper;

  AuthRepository(this._mapper);

  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> signInWithGoogle();

  Future<List<Movie>> getAllMovies();

  User get currentUser;

  String get currentUsername;
}
