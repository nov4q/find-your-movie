import 'package:json_annotation/json_annotation.dart';
part 'movie_dto.g.dart';

@JsonSerializable() // TODO? W bazie sa zaczynajace sie z duzych ;liter
class MovieDTO {
  MovieDTO({
    required this.title,
    required this.genre,
    required this.poster,
    required this.awards,
    required this.director,
    required this.production,
    required this.actors,
    required this.language,
    required this.year,
  });

  final String title;
  final String genre;
  final String poster;
  final String awards;
  final String director;
  final String production;
  final String actors;
  final String language;
  final String year;

  factory MovieDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDTOToJson(this);
}
