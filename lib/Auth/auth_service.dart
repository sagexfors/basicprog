import 'package:firebase_auth/firebase_auth.dart';

import '../services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address.';
      } else {
        throw 'Login failed. Please try again later.';
      }
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestoreService.createUserDocument(
        userCredential.user!.uid,
        name,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is invalid.';
      } else if (e.code == 'weak-password') {
        throw 'The password is too weak.';
      } else {
        throw 'Registration failed. Please try again later.';
      }
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
