import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //signIn
  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //signup

  Future<UserCredential> signUp(String email, password, username) async {
    try {
      //user created
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //saving user information in firestore
      _firestore.collection("Users").doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'email': email,
        'username': username,
      });

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

}
