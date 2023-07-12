import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:gradish/repositories/auth_repository.dart';
import '../core/enums.dart';
import '../core/failure.dart';


class AuthProvider extends ChangeNotifier {
  User? currentUser;
  final AuthRepository _authRepository;
  AppState state = AppState.initial;
  AuthState authState = AuthState.initial;
  String? errorMessage;

  AuthProvider(this._authRepository);

  Future<void> signInWithEmailAndPassword(LoginRequest credentials) async {
    state = AppState.submitting;
    notifyListeners();

    final Either<Failure, User?> response =
        await _authRepository.signInWithEmailAndPassword(credentials);

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (user) {
      errorMessage = null;
      state = AppState.success;
      currentUser = user;
    });
  }

  Future<void> registerWithEmailAndPassword(RegisterRequest credentials) async {
    state = AppState.submitting;
    notifyListeners();

    final Either<Failure, User?> response =
        await _authRepository.registerWithEmailAndPassword(credentials);

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (user) {
      errorMessage = null;
      state = AppState.success;
      currentUser = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    state = AppState.submitting;
    notifyListeners();

    final Either<Failure, User?> response =
        await _authRepository.signInWithGoogle();

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (user) {
      errorMessage = null;
      state = AppState.success;
      currentUser = user;
      notifyListeners();
    });
  }

  Future<void> logOut() async {
    state = AppState.submitting;
    notifyListeners();

    final Either<Failure, void> response = await _authRepository.logOut();

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (user) {
      errorMessage = null;
      state = AppState.success;
      currentUser = null;
      authState = AuthState.unauthenticated;
      notifyListeners();
    });
  }

  Future<void> authStateChanged() async {
    Either<Failure, Stream<User?>> response =
        await _authRepository.getAuthState();

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (userStream) {
      userStream.listen((user) {
        if (user == null) {
          authState = AuthState.unauthenticated;
          notifyListeners();
        } else {
          authState = AuthState.authenticated;
          notifyListeners();
        }
      });
    });
  }
}
