import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_dto.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/data/firebase/movies/movies_repo.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

@Injectable(as: MoviesRepo)
class MoviesRepositoryImpl implements MoviesRepo {

  MoviesRepositoryImpl(this._mapper);
  final MovieFromMovieDtoMapper _mapper;
  List<MovieDTO> _movieList = [];

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;


  @override
  Future<List<Movie>> getAllMovies() async {
    final db = firestore.collection('movies');

    await db.get().then(
      (data) {
        _movieList = data.docs
            .map(
              (document) => MovieDTO.fromJson(document.data()),
            )
            .toList();
      },
    );

    return _movieList.map((element) => _mapper(element)).toList();
  }
}
