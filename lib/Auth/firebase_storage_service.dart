import 'dart:developer' as developer;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Uploads a profile picture to Firebase Storage and returns the download URL.
  Future<String?> uploadProfilePicture(String userId, File image) async {
    try {
      final storageReference = _firebaseStorage.ref().child(
            'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}',
          );

      final uploadTask = storageReference.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      developer.log(
        'FirebaseException during upload: ${e.message}',
        name: 'FirebaseStorageService.uploadProfilePicture',
      );
      return null;
    } catch (e) {
      developer.log(
        'General Exception during upload: $e',
        name: 'FirebaseStorageService.uploadProfilePicture',
      );
      return null;
    }
  }

  // Deletes a profile picture from Firebase Storage. Returns true if deletion was successful.
  Future<bool> deleteProfilePicture(String userId) async {
    try {
      final storageReference =
          _firebaseStorage.ref().child('profile_pictures/$userId');

      final listResult = await storageReference.listAll();
      if (listResult.items.isNotEmpty) {
        await listResult.items.first.delete();
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      developer.log(
        'FirebaseException during deletion: ${e.message}',
        name: 'FirebaseStorageService.deleteProfilePicture',
      );
      return false;
    } catch (e) {
      developer.log(
        'General Exception during deletion: $e',
        name: 'FirebaseStorageService.deleteProfilePicture',
      );
      return false;
    }
  }
}
