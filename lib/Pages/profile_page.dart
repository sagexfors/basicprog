import 'package:basicprog/Widgets/generic_text_form_field.dart';
import 'package:basicprog/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: ADD NOTIFICATION IF SUCCESFUL UPDATE/ERROR

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<UserProvider>();
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
                future: userState.getUserProfilePicture(),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
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
                          TextButton(
                            onPressed: () async {
                              await userState.removeProfilePicture();
                            },
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
              TextButton(
                onPressed: () async {
                  await userState.uploadImage();
                },
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
                onPressed: () async {
                  await userState.updateProfileData(_nameController.text);
                },
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 100),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/change-password');
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
