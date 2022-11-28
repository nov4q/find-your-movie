import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_dto.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

import 'package:praca_inzynierska/domain/others/mapper/data_mapper.dart';

@injectable
class MovieFromMovieDtoMapper extends DataMapper<MovieDTO, Movie> {
  
  @override
  Movie call(MovieDTO data) {
    return Movie(
      title: data.title,
      genre: data.genre,
      poster: data.poster,
      awards: data.awards,
      director: data.director,
      production: data.production,
      actors: data.actors,
      language: data.language,
      year: data.year,
    );
  }
}
