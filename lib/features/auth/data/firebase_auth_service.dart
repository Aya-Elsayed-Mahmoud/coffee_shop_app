import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email/Password
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Sign in failed");
    }
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Sign up failed");
    }
  }

  // Google Sign In
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null; // user canceled
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  // Facebook Sign In
  Future<User?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) return null;
    final OAuthCredential facebookCredential = FacebookAuthProvider.credential(
      result.accessToken!.token,
    );
    final userCredential = await _auth.signInWithCredential(facebookCredential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
