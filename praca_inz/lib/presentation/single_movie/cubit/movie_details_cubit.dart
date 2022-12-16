import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';
import 'package:praca_inzynierska/use_case/movies/movies_use_case.dart';

part 'movie_details_state.dart';
part 'movie_details_cubit.freezed.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._moviesUseCase)
      : super(const MovieDetailsState.loading());

  final MoviesUseCase _moviesUseCase;
  List<Movie> movieDetails = [];

  void init() => emit(const MovieDetailsState.loading());

  Future<void> getMovieDetails(String movieTitle) async {
    emit(const _Loading());
    try {
      movieDetails = await _moviesUseCase.getSingleMovieDetails(movieTitle);
      if (movieDetails.first.title.isNotEmpty) {
        emit(_Idle(movieDetails));
      }
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> addToFavourites() async {
    try {
      await _moviesUseCase.addToFavourites(
        MovieRepresentation(
          title: movieDetails.first.title,
          poster: movieDetails.first.poster,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
