part of 'movie_details_cubit.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.idle(List<Movie> movieDetails) = _Idle;
  const factory MovieDetailsState.error(String error) = _Error;
  const factory MovieDetailsState.loading() = _Loading;
}
