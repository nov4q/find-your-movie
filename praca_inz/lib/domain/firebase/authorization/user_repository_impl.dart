// ignore: depend_on_referenced_packages
import 'package:cached_annotation/cached_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_representation_dto.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_dto_from_movie_representation_mapper.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_representation_from_movie_representation_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_representation_model.f.dart';

import '../../../data/firebase/authorization/user_repository.dart';

// part 'user_repository_impl.cached.dart';

// @withCache
@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._mapper,
    this.representationMapper,
    this.representationDtomapper,
  );

  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  final MovieFromMovieDtoMapper _mapper;
  final MovieRepresentationDtoFromMovieRepresentationMapper
      representationDtomapper;
  final MovieRepresentationFromMovieRepresentationDtoMapper
      representationMapper;

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final isNewUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (isNewUser.additionalUserInfo?.isNewUser ?? false) {
        firestore
            .collection('users')
            .doc(_firebaseAuth.currentUser?.uid)
            .set({'UUID': _firebaseAuth.currentUser?.uid});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  User get currentUser {
    final user = _firebaseAuth.currentUser;

    if (user == null) throw Exception('User not authenticated');
    return user;
  }

  @override
  String get currentUsername {
    final user = _firebaseAuth.currentUser;

    if (user == null) throw Exception('User not authenticated');
    return user.displayName ?? '';
  }

  /// Add to user colection
  @override
  Future<void> addToUserFavouriteMovies(MovieRepresentation movie) async {
    final favouritesCollection =
        firestore.collection('users/${currentUser.uid}/favourites');
    final MovieRepresentationDTO movieRepresentationDto =
        representationDtomapper(
      MovieRepresentation(
        poster: movie.poster,
        title: movie.title,
      ),
    );

    await favouritesCollection
        .doc(movie.title)
        .set(movieRepresentationDto.toJson());
  }

  @override
  Future<void> addToUserWatchlist(MovieRepresentation movie) async {
    // TODO: implement addToUserWatchlist
    throw UnimplementedError();
  }

  /// get User collection
  // @Cached()
  @override
  Future<List<MovieRepresentation>> getUserFavouriteMovies() async {
    List<MovieRepresentationDTO> movies = [];

    final favouritesCollection =
        firestore.collection('users/${currentUser.uid}/favourites');

    await favouritesCollection.get().then(
      (data) {
        movies = data.docs
            .map(
              (movie) => MovieRepresentationDTO.fromJson(movie.data()),
            )
            .toList();
      },
    );

    return movies.map((element) => representationMapper(element)).toList();
  }

  // @Cached()
  @override
  Future<List<MovieRepresentation>> getUserWatchlist() async {
    // TODO: implement getUserWatchlist
    throw UnimplementedError();
  }

  /// delete from user collection

  @override
  Future<void> deleteFromUserFavourites(MovieRepresentation movie) async {
    final favouritesCollection =
        firestore.collection('users/${currentUser.uid}/favourites');

    await favouritesCollection.doc(movie.title).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Future<void> deleteFromUserWatchlist(MovieRepresentation movie) async {
    // TODO: implement deleteFromUserWatchlist
    throw UnimplementedError();
  }
}
