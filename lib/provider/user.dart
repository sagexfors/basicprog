import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/firebase_storage_service.dart';
import '../Auth/firestore_service.dart';

// TODO: ADD NOTIFICATION IF SUCCESFUL UPDATE/ERROR, CATCH ERROR THINGS PLEASE CHECK IT

class UserProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();

  File? _image;

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
}
