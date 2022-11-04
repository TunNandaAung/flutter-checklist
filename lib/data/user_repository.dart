import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<firebase_auth.User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<firebase_auth.User?> updateProfile({
    required firebase_auth.User user,
    required String name,
    required String email,
  }) async {
    await user.updateEmail(email);
    await user.updateDisplayName(name);

    return getUser();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future changePassword({
    required firebase_auth.User user,
    required String currentPassword,
    required String newPassword,
  }) async {
    final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    print(credential);
    await user.reauthenticateWithCredential(credential).then((_) {
      user.updatePassword(newPassword).then((_) {
        print("Succesfully changed password");
      }).catchError((error) {
        print("Password can't be changed$error");
      });
    });
  }
}
