import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_representation_model.f.freezed.dart';

@freezed
class MovieRepresentation with _$MovieRepresentation {
  const factory MovieRepresentation({
    required String title,
    required String poster,
  }
  ) = _MovieRepresentation;
}

