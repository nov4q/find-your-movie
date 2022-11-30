// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'movie_dto.g.dart';

@JsonSerializable() // TODO? W bazie sa zaczynajace sie z duzych ;liter
class MovieDTO {
  MovieDTO(this.Plot, {
    required this.Title,
    required this.Genre,
    required this.Poster,
    required this.Awards,
    required this.Director,
    required this.Production,
    required this.Actors,
    required this.Language,
    required this.Year,
  });

  final String Title;
  final String Genre;
  final String Poster;
  final String Awards;
  final String Director;
  final String Production;
  final String Actors;
  final String Language;
  final String Year;
  final String Plot;

  factory MovieDTO.fromJson(Map<String, Object?> json) =>
      _$MovieDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDTOToJson(this);

 
}
