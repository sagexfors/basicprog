import 'package:basicprog/model/lesson/lesson.dart';
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

  // Method to retrieve all lessons
  Future<List<Lesson>> getLessons() async {
    try {
      final lessonsCollection = _firestore.collection('lessons').orderBy('id');
      final querySnapshot = await lessonsCollection.get();
      print("firestore lessons get");
      return querySnapshot.docs
          .map((doc) => Lesson.fromJson(doc.data()))
          .toList();
    } catch (e) {
      // Handle any errors that occur during fetching lessons
      throw Exception("Error fetching lessons from Firestore: $e");
    }
  }
  // Add more Firestore operations as needed...
}
