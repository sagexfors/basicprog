import 'package:basicprog/Pages/profile_page.dart';
import 'package:basicprog/Pages/quizzes_page.dart';
import 'package:basicprog/Pages/reset_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'activities_page.dart';
import 'lessons_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in ${FirebaseAuth.instance.currentUser!.email!}'),
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeaderWidget(user: user),
          DrawerItemWidget(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItemWidget(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          DrawerItemWidget(
            icon: Icons.book,
            title: 'Lessons',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LessonsPage()),
              );
            },
          ),
          DrawerItemWidget(
            icon: Icons.ondemand_video,
            title: 'Activities',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActivitiesPage()),
              );
            },
          ),
          DrawerItemWidget(
            icon: Icons.quiz,
            title: 'Quizzes',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizzesPage()),
              );
            },
          ),
          DrawerItemWidget(
            icon: Icons.lock,
            title: 'Reset Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordPage(),
                ),
              );
            },
          ),
          const Divider(),
          DrawerItemWidget(
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              Navigator.pushNamed(context, '/about-us');
            },
          ),
          const Spacer(),
          DrawerItemWidget(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  final User? user;

  const DrawerHeaderWidget({Key? key, required this.user}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
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
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl),
                  );
                } else {
                  // User is not logged in or doesn't have a profile picture, display default avatar
                  return const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/default_avatar.png'),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'Signed in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user!.email!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
