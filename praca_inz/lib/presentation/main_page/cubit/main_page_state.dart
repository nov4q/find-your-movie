part of 'main_page_cubit.dart';

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState.initial() = _Initial;
  const factory MainPageState.idle({required List<Movie> allMoviesList}) = _Idle;
}
