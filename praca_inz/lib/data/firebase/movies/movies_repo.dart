// ignore_for_file: unused_field

import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

abstract class MoviesRepo {
  final MovieFromMovieDtoMapper _mapper;

  MoviesRepo(this._mapper);

  Future<List<Movie>> getAllMovies();

  Future<List<Movie>> getTopRatedMovies();

  Future<List<Movie>> getMovieDetails(String title);
}
