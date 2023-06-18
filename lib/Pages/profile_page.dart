import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String _imageUrl = '';
  final String _defaultAvatarUrl =
      'assets/default_avatar.png'; // Replace with your default avatar image path

  Future<void> _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
        final storageReference = FirebaseStorage.instance.ref().child(
              'profile_pictures/${user.uid}/${DateTime.now().millisecondsSinceEpoch}',
            );
        final uploadTask = storageReference.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _imageUrl = downloadUrl;
        });
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

    // User is not logged in or doesn't have a profile picture
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String?>(
              future: _getUserProfilePicture(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
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
                    return CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(imageUrl),
                    );
                  } else {
                    // User is not logged in or doesn't have a profile picture, display default avatar
                    return const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/default_avatar.png'),
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
          ],
        ),
      ),
    );
  }
}
