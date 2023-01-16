// ignore_for_file: unused_field

import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_from_movie_representation_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

abstract class MoviesRepo {
  final MovieFromMovieDtoMapper _mapper;
  final MovieRepresentationFromMovieRepresentationDtoMapper
      _representationMapper;

  MoviesRepo(
    this._mapper,
    this._representationMapper,
  );

  Future<List<Movie>> getAllMovies();

  Future<List<MovieRepresentation>> getTopRatedMovies();

  Future<List<MovieRepresentation>> getPopularMovies();

  Future<List<MovieRepresentation>> getSearchCollection();

  Future<List<Movie>> getMovieDetails(String title);

  Future<void> addToCollection(
    List<Movie> movies,
    String collectionName,
  );
}
