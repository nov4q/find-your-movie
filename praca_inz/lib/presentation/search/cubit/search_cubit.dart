import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';
import 'package:praca_inzynierska/use_case/movies/movies_use_case.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._moviesUseCase) : super(const SearchState.loading());

  List<MovieRepresentation> results = [];
  List<MovieRepresentation> allMovies = [];

  final MoviesUseCase _moviesUseCase;

  Future<void> init() async {
    _emitLoading();

    try {
      allMovies = await _moviesUseCase.getSearchCollection();
      _emitIdle();
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  void _emitIdle() {
    emit(SearchState.idle(allMovies));
  }

  void _emitLoading() {
    emit(const SearchState.loading());
  }

  void _emitSearchResults() {
    emit(SearchState.searchResults(
      results,
      allMovies,
    ));
  }

  void clearResults() {
    results = [];
    _emitSearchResults();
  }

  void searchMovie(String? query) {
    if ((query?.isNotEmpty) ?? false) {
      results = allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    } else {
      results = [];
    }
    _emitSearchResults();
  }
}
