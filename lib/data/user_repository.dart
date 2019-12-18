import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return (await _firebaseAuth.currentUser());
  }

  Future<void> signUp({String name, String email, String password}) async {
    AuthResult auth = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;

    await auth.user.updateProfile(userUpdateInfo);
    await auth.user.reload();
  }

  Future<FirebaseUser> updateProfile(
      {FirebaseUser user, String name, String email}) async {
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;

    await user.updateEmail(email);
    await user.updateProfile(userUpdateInfo);

    return this.getUser();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future changePassword(
      {FirebaseUser user, String currentPassword, String newPassword}) async {
    final credential = EmailAuthProvider.getCredential(
        email: user.email, password: currentPassword);
    print(credential);
    await user.reauthenticateWithCredential(credential).then((_) {
      user.updatePassword(newPassword).then((_) {
        print("Succesfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
      });
    });
  }
}
