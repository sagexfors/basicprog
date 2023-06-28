import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserDocument(String userId, String name) async {
    await _firestore.collection('users').doc(userId).set({'name': name});
  }

  // Add more Firestore operations as needed...
}
