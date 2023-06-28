import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserDocument(String userId, String name) async {
    await _firestore.collection('users').doc(userId).set({'name': name});
  }

  Future<void> updateUserName(String userId, String name) async {
    try {
      final usersCollection = _firestore.collection('users');
      final docSnapshot = await usersCollection.doc(userId).get();

      if (docSnapshot.exists) {
        await usersCollection.doc(userId).update({'name': name});
      } else {
        await usersCollection.doc(userId).set({'name': name});
      }
    } catch (e) {
      // Handle any errors that occur during the update
    }
  }
  // Add more Firestore operations as needed...
}
