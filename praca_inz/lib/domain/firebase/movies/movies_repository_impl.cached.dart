// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'movies_repository_impl.dart';

// **************************************************************************
// CachedGenerator
// **************************************************************************

abstract class _$MoviesRepositoryImpl {
  MovieFromMovieDtoMapper get mapper;
}

class _MoviesRepositoryImpl
    with MoviesRepositoryImpl
    implements _$MoviesRepositoryImpl {
  _MoviesRepositoryImpl(this.mapper);

  @override
  final MovieFromMovieDtoMapper mapper;

  final _getAllMoviesCached = <String, List<Movie>>{};
  final _getTopRatedMoviesCached = <String, List<Movie>>{};
  final _getMovieDetailsCached = <String, List<Movie>>{};

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

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    final cachedValue = _getTopRatedMoviesCached[""];
    if (cachedValue == null) {
      final List<Movie> toReturn;
      try {
        final result = super.getTopRatedMovies();

        toReturn = await result;
      } catch (_) {
        rethrow;
      } finally {}

      _getTopRatedMoviesCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  Future<List<Movie>> getMovieDetails(String title) async {
    final cachedValue = _getMovieDetailsCached["${title.hashCode}"];
    if (cachedValue == null) {
      final List<Movie> toReturn;
      try {
        final result = super.getMovieDetails(title);

        toReturn = await result;
      } catch (_) {
        rethrow;
      } finally {}

      _getMovieDetailsCached["${title.hashCode}"] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }
}
