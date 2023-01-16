import 'package:injectable/injectable.dart';

import 'package:praca_inzynierska/data/firebase/dtos/movie_representation_dto.dart';

import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

import 'package:praca_inzynierska/domain/others/mapper/data_mapper.dart';

@injectable
class MovieRepresentationDtoFromMovieRepresentationMapper
    extends DataMapper<MovieRepresentation, MovieRepresentationDTO> {
  @override
  MovieRepresentationDTO call(MovieRepresentation data) {
    return MovieRepresentationDTO(
      title: data.title,
      poster: data.poster,
    );
  }
}
