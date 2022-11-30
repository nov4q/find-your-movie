import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_dto.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

import 'package:praca_inzynierska/domain/others/mapper/data_mapper.dart';

@injectable
class MovieFromMovieDtoMapper extends DataMapper<MovieDTO, Movie> {
  @override
  Movie call(MovieDTO data) {
    return Movie(
      title: data.Title,
      genre: data.Genre,
      poster: data.Poster,
      awards: data.Awards,
      director: data.Director,
      production: data.Production,
      actors: data.Actors,
      language: data.Language,
      year: data.Year,
    );
  }
}
