import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:gradish/services/auth_service/firebase_auth_service.dart';
import 'package:dartz/dartz.dart';

import '../core/failure.dart';

class AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepository(this._authService);

  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      LoginRequest credentials) async {
    try {
      final UserCredential? userCredential =
          await _authService.loginWithEmailAndPassword(credentials);
      User? user = userCredential?.user;
      if (user == null) {
        return Left(Failure());
      }
      return Right(user);
    }on FirebaseAuthException catch (e){
      return Left(Failure(errorMessage: e.message));
    }
    on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, User?>> registerWithEmailAndPassword(
      RegisterRequest credentials) async {
    try {
      final UserCredential? userCredential =
          await _authService.registerWithEmailAndPassword(credentials);
      User? user = userCredential?.user;
      if (user == null) {
        return Left(Failure());
      }
      return Right(user);
    }on FirebaseAuthException catch (e){
      return Left(Failure(errorMessage: e.message));
    }
    on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      final UserCredential? userCredential =
          await _authService.signInWithGoogle();

      User? user = userCredential?.user;
      if (user == null) {
        return Left(Failure());
      }
      return Right(user);
    }on FirebaseAuthException catch (e){
      return Left(Failure(errorMessage: e.message));
    }
    on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> logOut() async {
    try {

      await _authService.logOut();

      return const Right(null);
    }on FirebaseAuthException catch (e){
      return Left(Failure(errorMessage: e.message));
    }
    on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, Stream<User?>>> getAuthState() async {

    try {
      Stream<User?> authStateStream = _authService.getAuthStateChanges();

      return Right(authStateStream);
    } on FirebaseAuthException catch (e){
      return Left(Failure(errorMessage: e.message));
    }

    on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }




  }
}


