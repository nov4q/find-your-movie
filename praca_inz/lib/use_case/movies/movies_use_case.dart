import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/movies/movies_repo.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

@injectable
class MoviesUseCase {
  final MoviesRepo _authRepository;

  MoviesUseCase(this._authRepository);

  Future<List<Movie>> getAllMoviesUseCase() async =>
      _authRepository.getAllMovies();

  Future<List<Movie>> getTopRatedMoviesUseCase() async =>
      _authRepository.getTopRatedMovies();

  Future<List<Movie>> getSingleMovieDetails(String title) async =>
      _authRepository.getMovieDetails(title);
}
