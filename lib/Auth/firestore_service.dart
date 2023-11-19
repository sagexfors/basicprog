import 'package:basicprog/model/lesson/lesson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Retrieve the user's completed lessons
      final userDoc = await getUserDocument(user.uid);
      Map<String, dynamic> userLessons = userDoc.data()?['lessons'] ?? {};
      print(userLessons);

      // Retrieve all lessons from Firestore
      final lessonsCollection = _firestore.collection('lessons').orderBy('id');
      final querySnapshot = await lessonsCollection.get();

      // Update lessons based on completion status
      return querySnapshot.docs.map((doc) {
        var lessonData = doc.data();
        String lessonId = doc.id;
        bool isCompleted = userLessons[lessonId]?['completed'] ?? false;

        // Assuming your Lesson model can take a 'completed' parameter
        return Lesson.fromJson(lessonData, completed: isCompleted);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching lessons from Firestore: $e");
    }
  }

  // Method to get a user document
  // Method to get a user document
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument(
    String userId,
  ) async {
    return await _firestore.collection('users').doc(userId).get();
  }

  // Method to update a user document
  Future<void> updateUserDocument(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore.collection('users').doc(userId).update(updates);
  }
  // Add more Firestore operations as needed...
}
