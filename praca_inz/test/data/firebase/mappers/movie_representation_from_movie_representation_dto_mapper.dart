import 'package:flutter_test/flutter_test.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_representation_dto.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_from_movie_representation_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

// Test dla MovieRepresentationFromMovieRepresentationDtoMapper
// Sprawdza, czy maper poprawnie odwzorowuje MovieRepresentationDTO
// do obiektu MovieRepresentation
void main() {
  // Utwórz instancję mappera
  MovieRepresentationFromMovieRepresentationDtoMapper mapper;
  mapper = MovieRepresentationFromMovieRepresentationDtoMapper();

  group('call', () {
    test('should return Movie object', () {
      // Arrange
      // Utwórz dane testowe
      final movieRepresentationDTO = MovieRepresentationDTO(
        title: 'Movie 1',
        poster: 'https://example.com/poster1.jpg',
      );
      // Act  
      // Mapuj objekt DTO do dobiektu domenowego
      final result = mapper(movieRepresentationDTO);
      // Assert
      // Sprawdź poprawność obiektu
      expect(result, isA<MovieRepresentation>());
      // Sprawdź poprawność danych
      expect(result.title, 'Movie 1');
      expect(result.poster, 'https://example.com/poster1.jpg');
    });
  });
}
