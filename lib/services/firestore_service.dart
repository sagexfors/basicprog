import 'package:basicprog/model/lesson/lesson.dart';
import 'package:basicprog/model/question.dart';
import 'package:basicprog/model/quiz.dart';
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

  Future<List<Lesson>> getLessons() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Retrieve the user's completed lessons
      final userDoc = await getUserDocument(user.uid);
      Map<String, dynamic> userLessons = userDoc.data()?['lessons'] ?? {};

      // Retrieve all lessons from Firestore
      final lessonsCollection = _firestore.collection('lessons').orderBy('id');
      final querySnapshot = await lessonsCollection.get();

      // Update lessons based on completion status
      return querySnapshot.docs.map((doc) {
        var lessonData = doc.data();
        String lessonId = doc.id;
        bool isCompleted = userLessons[lessonId]?['completed'] ??
            false; ////////////////////////////

        // Assuming your Lesson model can take a 'completed' parameter
        return Lesson.fromJson(lessonData, completed: isCompleted);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching lessons from Firestore: $e");
    }
  }

  Future<List<Quiz>> getQuizzes() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Retrieve the user's quizzes scores
      final userDoc = await getUserDocument(user.uid);
      Map<String, dynamic> userQuizzesScores = userDoc.data()?['quizzes'] ?? {};

      final questionsCollection =
          _firestore.collection('quizzes').orderBy('id');
      final querySnapshot = await questionsCollection.get();

      return querySnapshot.docs.map((doc) {
        var quizData = doc.data();
        String quizId = doc.id;
        double? score = userQuizzesScores[quizId]?['score'];
        return Quiz.fromJson(quizData, score: score);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching quizzes from Firestore: $e");
    }
  }

  Future<List<Quiz>> getQuestions() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Retrieve all questions from Firestore
      final questionsCollection =
          _firestore.collection('questions').orderBy('id');
      final querySnapshot = await questionsCollection.get();

      List<dynamic> questionsData =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      // Shuffle the questions once
      questionsData.shuffle();

      // Take the first 100 questions (or all questions if there are fewer than 100)
      List<dynamic> selectedQuestionsData = questionsData.take(100).toList();

      final List<Quiz> assessments = [];

      // Loop to create 5 assessments
      for (int assessmentIndex = 1; assessmentIndex <= 5; assessmentIndex++) {
        // Calculate start and end index for slicing the questions for each assessment
        int startIndex = (assessmentIndex - 1) * 20;
        int endIndex = startIndex + 20;

        // Take 20 questions for the assessment, handling cases where there are fewer than 100 questions
        final assessmentQuestionsData = selectedQuestionsData.sublist(
            startIndex,
            endIndex > selectedQuestionsData.length
                ? selectedQuestionsData.length
                : endIndex);

        final assessmentQuestions = assessmentQuestionsData.map((questionData) {
          // Assuming Question has a fromJson method
          return Question.fromJson(questionData as Map<String, dynamic>);
        }).toList();

        // Create an Assessment quiz and add it to the list
        final assessment = Quiz(
          title: 'Assessment $assessmentIndex',
          description: 'This is a 20-question assessment.',
          questions: assessmentQuestions,
          id: assessmentIndex, // Or assign a unique ID based on your requirements
          score: null,
        );

        assessments.add(assessment);
      }

      // Return the list of assessments
      return assessments;
    } catch (e) {
      throw Exception("Error fetching questions from Firestore: $e");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument(
    String userId,
  ) async {
    return await _firestore.collection('users').doc(userId).get();
  }

  Future<void> updateUserDocument(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore.collection('users').doc(userId).update(updates);
  }

  Future<void> updateUserQuizScore(
    String userId,
    String quizId,
    double score,
  ) async {
    await _firestore.collection('users').doc(userId).set(
      {
        'quizzes': {
          quizId: {'score': score},
        },
      },
      SetOptions(merge: true),
    );
  }

  Future<void> updateUserAssessmentScore(
    String userId,
    String assessmentId,
    double score,
  ) async {
    await _firestore.collection('users').doc(userId).set(
      {
        'assessments': {
          assessmentId: {'score': score},
        },
      },
      SetOptions(merge: true),
    );
  }
}
