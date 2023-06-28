import 'dart:io';

import 'package:basicprog/Pages/change_password_page.dart';
import 'package:basicprog/Widgets/generic_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/firebase_storage_service.dart';
import '../Auth/firestore_service.dart';

// TODO: REMOVE OLD PROFILE PIC IF UPDATED
// TODO: FIREBASE_AUTH IS USED TO FETCH CURRENT USER, MAKE SURE TO PUT THAT STATE SOMEWHERE LATER
// TODO: ADD A BUTTON TO REMOVE PROFILE PIC AND RESET TO DEFAULT AVATAR
// PROBLEM IS IF YOU UPLOAD A PICTURE WHILE A PFP EXISTS, IT DOESN'T DELETE THE OLD PFP AND DOESN'T EVEN USE THE NEW PFP
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();

  File? _image;
  String _imageUrl = '';
  final String _defaultAvatarUrl =
      'assets/default_avatar.png'; // Replace with your default avatar image path
  final TextEditingController _nameController = TextEditingController();

  Future<void> _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });

        final imageUrl = await _firebaseStorageService.uploadProfilePicture(
          user.uid,
          _image!,
        );
        if (imageUrl != null) {
          setState(() {
            _imageUrl = imageUrl;
          });
        } else {
          // Handle the case when the image upload fails
        }
      }
    }
  }

  Future<String?> _getUserProfilePicture() async {
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

  Future<void> _removeProfilePicture() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firebaseStorageService.deleteProfilePicture(user.uid);
      setState(() {
        _imageUrl = '';
      });
    }
  }

  Future<void> _updateProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = _nameController.text.trim();
      if (name.isEmpty) {
        return;
      }

      await _firestoreService.updateUserName(user.uid, name);

      // Show a success message or perform any other actions after successful update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              FutureBuilder<String?>(
                future: _getUserProfilePicture(),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show a loading indicator
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If an error occurred while fetching the profile picture, show an error message
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final imageUrl = snapshot.data;
                    if (imageUrl != null) {
                      // User has a profile picture, display it in the CircleAvatar
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _removeProfilePicture,
                            child: const Text('Remove Picture'),
                          ),
                        ],
                      );
                    } else {
                      // User is not logged in or doesn't have a profile picture, display default avatar
                      return const CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            AssetImage('assets/default_avatar.png'),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Upload Picture'),
              ),
              const SizedBox(height: 30),
              GenericTextFormField(
                icon: Icons.person,
                labelText: 'Name',
                controller: _nameController,
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: _updateProfileData,
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
                child: const Text('Change Password'),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
