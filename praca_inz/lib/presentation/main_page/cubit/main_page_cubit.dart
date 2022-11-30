import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/use_case/movies/movies_use_case.dart';

part 'main_page_state.dart';
part 'main_page_cubit.freezed.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit(this._moviesUseCase) : super(const MainPageState.initial());
  final MoviesUseCase _moviesUseCase;
  List<Movie> allMoviesList = [];

  Future<void> init() async {
    await getMovies();
    _emitIdle();
  }

  void _emitIdle() => emit(_Idle(allMoviesList: allMoviesList));

  Future<void> getMovies() async =>
      allMoviesList = await _moviesUseCase.getAllMoviesUseCase();

  String getName() => allMoviesList.first.title;
}
