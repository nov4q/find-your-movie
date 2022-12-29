import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';
import 'package:praca_inzynierska/presentation/style/app_dimens.dart';
import 'package:praca_inzynierska/use_case/movies/movies_use_case.dart';

part 'main_page_state.dart';
part 'main_page_cubit.freezed.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit(this._moviesUseCase) : super(const MainPageState.initial());
  final MoviesUseCase _moviesUseCase;

  List<Movie> allMoviesList = [];
  List<MovieRepresentation> topRatedMoviesList = [];
  List<MovieRepresentation> popularMoviesList = [];
  List<MovieRepresentation> favouriteMoviesList = [];
  List<MovieRepresentation> userWatchlist = [];

  Future<void> init() async {
    try {
      await getMovies();
      await getTopRatedMovies();
      await getPopularMovies();
      await getFavouriteMovies();
      await getWatchlist();
      await Future.delayed(AppDimens.duration1s);
      _emitIdle();
    } catch (e) {
      print(e);
    }
  }

  Future<void> initUnauthenticated() async {
    try {
      await getTopRatedMovies();
      await Future.delayed(AppDimens.duration1s);
      _emitUnauth();
    } catch (e) {
      print(e);
    }
  }

  void _emitIdle() => emit(_Idle(
        allMoviesList: allMoviesList,
        topRatedMoviesList: topRatedMoviesList,
        popularMoviesList: popularMoviesList,
        favouriteMoviesList: favouriteMoviesList,
        userWatchlist: userWatchlist,
      ));
  void _emitUnauth() =>
      emit(_UnAuthenticated(topRatedMoviesList: topRatedMoviesList));

  Future<void> getMovies() async =>
      allMoviesList = await _moviesUseCase.getAllMoviesUseCase();

  Future<void> getTopRatedMovies() async =>
      topRatedMoviesList = await _moviesUseCase.getTopRatedMoviesUseCase();

  Future<void> getPopularMovies() async =>
      popularMoviesList = await _moviesUseCase.getPopularMoviesUseCase();

  Future<void> getFavouriteMovies() async =>
      favouriteMoviesList = await _moviesUseCase.getFavouriteMovies();

  Future<void> getWatchlist() async =>
      userWatchlist = await _moviesUseCase.getWatchlist();

  String getName() => allMoviesList.first.title;

  Future<void> getMovieDetails(String title) async =>
      _moviesUseCase.getSingleMovieDetails(title);

  Future<void> addToCollection(
    List<Movie> movies,
    String collectionName,
  ) async {
    try {
      _moviesUseCase.addToCustomCollection(
        movies,
        collectionName,
      );
    } catch (e) {
      print(e);
    }
  }
}
