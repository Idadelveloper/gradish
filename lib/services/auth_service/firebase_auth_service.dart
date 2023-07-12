import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  Future<UserCredential?> loginWithEmailAndPassword(
      LoginRequest parameter) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
            email: parameter.email, password: parameter.password);
    return userCredential;
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      RegisterRequest parameter) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: parameter.email, password: parameter.password);
    return userCredential;
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    //Get the current signed In google account

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    //Creates a google authentication
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

    //Gets the Auth credentials
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken) as GoogleAuthCredential;

    //Creates an account on Firebase using those crdentials

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(googleAuthCredential);

    return userCredential;
  }


  Stream<User?> getAuthStateChanges(){
    return _firebaseAuth.authStateChanges();
  }

}
