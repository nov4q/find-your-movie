import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/authorization/user_repository.dart';
import 'package:praca_inzynierska/data/firebase/movies/movies_repo.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

@injectable
class MoviesUseCase {
  final MoviesRepo _moviesRepository;
  final UserRepository _userRepository;

  MoviesUseCase(
    this._moviesRepository,
    this._userRepository,
  );

  /// get movies collections
  Future<List<Movie>> getAllMoviesUseCase() async =>
      _moviesRepository.getAllMovies();

  Future<List<MovieRepresentation>> getTopRatedMoviesUseCase() async =>
      _moviesRepository.getTopRatedMovies();

  Future<List<MovieRepresentation>> getPopularMoviesUseCase() async =>
      _moviesRepository.getPopularMovies();

  Future<List<Movie>> getSingleMovieDetails(String title) async =>
      _moviesRepository.getMovieDetails(title);

  /// get search collection
  Future<List<MovieRepresentation>> getSearchCollection() async =>
      _moviesRepository.getSearchCollection();

  /// get users collection
  Future<List<MovieRepresentation>> getFavouriteMovies() async =>
      _userRepository.getUserFavouriteMovies();

  Future<List<MovieRepresentation>> getWatchlist() async =>
      _userRepository.getUserWatchlist();

  /// add to users collection
  Future<void> addToFavourites(MovieRepresentation movieRepresentation) async =>
      _userRepository.addToUserFavouriteMovies(movieRepresentation);

  Future<void> addToWatchlist(MovieRepresentation movieRepresentation) async =>
      _userRepository.addToUserWatchlist(movieRepresentation);

  /// delete from users collection
  Future<void> deleteFromFavourites(
          MovieRepresentation movieRepresentation) async =>
      _userRepository.deleteFromUserFavourites(movieRepresentation);

  Future<void> deleteFromWatchlist(
          MovieRepresentation movieRepresentation) async =>
      _userRepository.deleteFromUserWatchlist(movieRepresentation);

  Future<void> addToCustomCollection(
    List<Movie> movies,
    String collectionName,
  ) async =>
      _moviesRepository.addToCollection(
        movies,
        collectionName,
      );
}
