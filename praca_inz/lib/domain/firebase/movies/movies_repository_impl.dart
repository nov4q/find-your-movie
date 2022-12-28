// ignore: depend_on_referenced_packages
import 'package:cached_annotation/cached_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_dto.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_representation_dto.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_dto_from_movie_representation_mapper.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_from_movie_representation_dto_mapper.dart';
import 'package:praca_inzynierska/data/firebase/movies/movies_repo.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

part 'movies_repository_impl.cached.dart';

@withCache
@Injectable(as: MoviesRepo)
abstract class MoviesRepositoryImpl
    implements MoviesRepo, _$MoviesRepositoryImpl {
  @factoryMethod
  factory MoviesRepositoryImpl(
    MovieFromMovieDtoMapper mapper,
    MovieRepresentationFromMovieRepresentationDtoMapper representationMapper,
    MovieRepresentationDtoFromMovieRepresentationMapper representationDtoMapper,
  ) = _MoviesRepositoryImpl;

  List<MovieDTO> _movieList = [];
  List<MovieRepresentationDTO> _movieRepresentationList = [];

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  @Cached()
  @override
  Future<List<Movie>> getAllMovies() async {
    final allMoviesCollection = firestore.collection('all-movies');
    await allMoviesCollection.get().then(
      (data) {
        _movieList = data.docs
            .map(
              (movie) => MovieDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return _movieList.map((element) => mapper(element)).toList();
  }

  @Cached()
  @override
  Future<List<MovieRepresentation>> getTopRatedMovies() async {
    final allMoviesCollection = firestore.collection('top-rated-movies');
    await allMoviesCollection.get().then(
      (data) {
        _movieRepresentationList = data.docs
            .map(
              (movie) => MovieRepresentationDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return _movieRepresentationList
        .map((element) => representationMapper(element))
        .toList();
  }

  @Cached()
  @override
  Future<List<MovieRepresentation>> getSearchCollection() async {
    final allMoviesCollection = firestore.collection('search-titles');
    await allMoviesCollection.get().then(
      (data) {
        _movieRepresentationList = data.docs
            .map(
              (movie) => MovieRepresentationDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return _movieRepresentationList
        .map((element) => representationMapper(element))
        .toList();
  }

  @Cached()
  @override
  Future<List<MovieRepresentation>> getPopularMovies() async {
    final allMoviesCollection = firestore.collection('popular-movies');
    await allMoviesCollection.get().then(
      (data) {
        _movieRepresentationList = data.docs
            .map(
              (movie) => MovieRepresentationDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return _movieRepresentationList
        .map((element) => representationMapper(element))
        .toList();
  }

  @Cached()
  @override
  Future<List<Movie>> getMovieDetails(String title) async {
    final allMoviesCollection =
        firestore.collection('all-movies').where('Title', isEqualTo: title);
    await allMoviesCollection.get().then(
      (data) {
        _movieList = data.docs
            .map(
              (movie) => MovieDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return _movieList.map((element) => mapper(element)).toList();
  }

  @override
  Future<void> addToCollection(
      List<Movie> movies, String collectionName) async {
    final favouritesCollection = firestore.collection(collectionName);
    for (final movie in movies) {
      final MovieRepresentationDTO movieRepresentationDto =
          representationDtoMapper(
        MovieRepresentation(
          poster: movie.poster,
          title: movie.title,
        ),
      );

      await favouritesCollection
          .doc(movie.title)
          .set(movieRepresentationDto.toJson());
    }
  }
}
