// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'movies_repository_impl.dart';

// **************************************************************************
// CachedGenerator
// **************************************************************************

abstract class _$MoviesRepositoryImpl {
  MovieFromMovieDtoMapper get _mapper;
}

class _MoviesRepositoryImpl
    with MoviesRepositoryImpl
    implements _$MoviesRepositoryImpl {
  _MoviesRepositoryImpl(this._mapper);

  @override
  final MovieFromMovieDtoMapper _mapper;

  final _getAllMoviesCached = <String, List<Movie>>{};

  @override
  Future<List<Movie>> getAllMovies() async {
    final cachedValue = _getAllMoviesCached[""];
    if (cachedValue == null) {
      final List<Movie> toReturn;
      try {
        final result = super.getAllMovies();

        toReturn = await result;
      } catch (_) {
        rethrow;
      } finally {}

      _getAllMoviesCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }
}
