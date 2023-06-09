import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          DrawerHeader(
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
                  user.email!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              // Handle home item press
            },
          ),
          ListTile(
            title: const Text('Lessons'),
            leading: const Icon(Icons.book),
            onTap: () {
              // Handle lessons item press
            },
          ),
          ListTile(
            title: const Text('Activities'),
            leading: const Icon(Icons.ondemand_video),
            onTap: () {
              // Handle activities item press
            },
          ),
          ListTile(
            title: const Text('Quizzes'),
            leading: const Icon(Icons.quiz),
            onTap: () {
              // Handle quizzes item press
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('About Us'),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.pushNamed(context, '/about-us');
            },
          ),
          const Spacer(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
