import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProfilePicture(String userId, File image) async {
    try {
      final storageReference = _firebaseStorage.ref().child(
          'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}',);

      final uploadTask = storageReference.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Handle any errors that occur during the upload
      return null;
    }
  }

  Future<void> deleteProfilePicture(String userId) async {
    try {
      final storageReference =
          _firebaseStorage.ref().child('profile_pictures/$userId');

      final listResult = await storageReference.listAll();
      if (listResult.items.isNotEmpty) {
        await listResult.items.first.delete();
      }
    } catch (e) {
      // Handle any errors that occur during the deletion
    }
  }

  // Add more Firebase Storage operations as needed...
}
