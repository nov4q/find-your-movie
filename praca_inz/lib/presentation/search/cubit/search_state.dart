part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.loading() = _Loading;
  const factory SearchState.error(String error) = _Error;
  const factory SearchState.idle(
    List<MovieRepresentation> allMovies,
  ) = _Idle;
  const factory SearchState.searchResults(
    List<MovieRepresentation> results,
    List<MovieRepresentation> allMovies,
  ) = _SearchResults;
}
