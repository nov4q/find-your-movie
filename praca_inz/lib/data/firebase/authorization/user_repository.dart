// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

abstract class UserRepository {
  final MovieFromMovieDtoMapper _mapper;

  UserRepository(this._mapper);

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



  User get currentUser;

  String get currentUsername;

  Future<List<MovieRepresentation>> getUserFavouriteMovies();

  Future<void> addToUserFavouriteMovies(MovieRepresentation movie);

  Future<List<MovieRepresentation>> getUserWatchlist();

  Future<void> addToUserWatchlist(MovieRepresentation movie);

  Future<void> deleteFromUserWatchlist(MovieRepresentation movie);

  Future<void> deleteFromUserFavourites(MovieRepresentation movie);
}
