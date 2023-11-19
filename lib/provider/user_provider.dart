import 'dart:io';

import 'package:basicprog/auth/firebase_storage_service.dart';
import 'package:basicprog/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();

  File? _image;

  final double _progress = 0.0;

  double get progress => _progress;

  Future<void> uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        // Delete the existing profile picture, if it exists
        await _firebaseStorageService.deleteProfilePicture(user.uid);

        _image = File(pickedImage.path);

        await _firebaseStorageService.uploadProfilePicture(
          user.uid,
          _image!,
        );
      }
    }
    notifyListeners();
  }

  Future<String?> getUserProfilePicture() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final storageReference =
          FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}');
      final listResult = await storageReference.listAll();

      if (listResult.items.isNotEmpty) {
        // User has a profile picture, retrieve the first image in the folder
        final profilePictureRef = listResult.items.first;
        final imageUrl = await profilePictureRef.getDownloadURL();
        return imageUrl;
      }
    }
    // User is not logged in or doesn't have a profile picture, return null
    return null;
  }

  Future<void> removeProfilePicture() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firebaseStorageService.deleteProfilePicture(user.uid);
    }
    notifyListeners();
  }

  Future<void> updateProfileData(String newName) async {
    final user = FirebaseAuth.instance.currentUser;
    final name = newName.trim();
    if (user != null) {
      if (name.isEmpty) {
        return;
      }

      await _firestoreService.updateUserName(user.uid, name);

      // Show a success message or perform any other actions after successful update
    }
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user
        ?.uid; // This will return the user's UID or null if no user is logged in
  }

  Future<void> markLessonReadOrUnread(String lessonId, bool isRead) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      // Retrieve the user document
      final userDoc = await _firestoreService.getUserDocument(userId);
      Map<String, dynamic> userData = userDoc.data() ?? {};

      // Update or create the lessons field
      Map<String, dynamic> lessons = userData['lessons'] ?? {};
      lessons[lessonId] = {'completed': isRead};

      // Update the user document
      await _firestoreService.updateUserDocument(userId, {
        'lessons': lessons,
      });
    }
  }

  void clear() {
    _image = null;
  }
}
