import 'package:basicprog/Pages/profile_page.dart';
import 'package:basicprog/Pages/quizzes_page.dart';
import 'package:basicprog/Pages/reset_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                MaterialPageRoute(builder: (context) => ProfilePage()),
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
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user!.photoURL ?? ''),
            //TODO: get image from cloud firestore instead. if no image then default avatar.
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
