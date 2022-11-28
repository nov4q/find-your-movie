import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.f.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String title,
    required String genre,
    required String poster,
    required String awards,
    required String director,
    required String production,
    required String actors,
    required String language,
    required String year,
  }) = _Movie;
}
