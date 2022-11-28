import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:praca_inzynierska/data/firebase/dtos/movie_dto.dart';
import 'package:praca_inzynierska/data/firebase/mappers/movie_from_movie_dto_mapper.dart';
import 'package:praca_inzynierska/domain/firebase/models/movie/movie_model.f.dart';

import '../../../data/firebase/authorization/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._mapper);

  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  final MovieFromMovieDtoMapper _mapper;

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

      await FirebaseAuth.instance.signInWithCredential(credential);
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

  late List<MovieDTO> _movieList;

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
