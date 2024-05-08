import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantshop/models/model_user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  /// create user
  Future<UserModel?> signUpUser(
      String email,
      String password,
      ) async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        UserModel userModel = UserModel();
        userModel.id = firebaseUser.uid;
        userModel.email = firebaseUser.email!;
        userModel.displayName = firebaseUser.displayName!;

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  ///signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
// ... (other methods)}
}