// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'movie_representation_dto.g.dart';

@JsonSerializable()
class MovieRepresentationDTO {
  MovieRepresentationDTO({
    required this.title,
    required this.poster,
  });

  final String title;
  final String poster;

  factory MovieRepresentationDTO.fromJson(Map<String, Object?> json) =>
      _$MovieRepresentationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieRepresentationDTOToJson(this);
}
