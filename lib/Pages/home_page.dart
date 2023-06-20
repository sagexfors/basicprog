import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'activities_page.dart';
import 'lessons_page.dart';
import 'profile_page.dart';
import 'quizzes_page.dart';
import 'reset_password_page.dart';

final List<Lesson> lessonList = [
  Lesson(
    title: "Lesson 1: Introduction to C Language",
    description: "An introduction to the C programming language.",
    content: [
      "Programming language is the language that will serve as the medium between the human and the machine or the computer. It is a set of grammatical rules for instructing a computer or any computing device to perform specific tasks.",
      "There are categories of programming language, these are:",
      "- Machine Language where instructions are written in 0’s and 1’s...",
      "- Low-level language or assembly language where instructions are written in mnemonic code/symbols...",
      "- High-level language are those instructions that have resemblance to our English language statements...",
      "Translators Programs:",
      "Translator Programs are programs that are utilized by a particular programming language to translate instructions written either in low-level language or high-level language...",
      "- Assembler. It translates program written in assembly language or low-level language into machine language...",
      "- Interpreter. It translates program written in high-level language into machine language one statement/command at a time...",
      "- Compiler. It translates program written in high-level language into machine language...",
      "What is C Language?...",
      "C programming language was developed in 1972 by Dennis Ritchie at Bell Laboratories...",
      "Why need to learn C programming?...",
      "It is vital to fully understand as to why should learn C programming...",
      "C programming is referred to as the mother language since it forms the foundation for all other programming languages...",
      "It can be defined by the following ways:...",
      "- C as mother language...",
      "- C as system programming language...",
      "- C as procedural language...",
      "- C as structured programming language...",
      "- C as mid-level programming language...",
      "Application of C Programming...",
      "C was first used for system development, namely for the programs that comprise the operating system...",
      "1. Operating System",
      "2. Language Compilers",
      "3. Assemblers",
      "4. Text Editors",
      "5. Network Drivers",
      "6. Modern Programs",
      "7. Databases",
      "8. Language Interpreters",
      "9. Utilities",
      "10. Print Spoolers"
    ],
  ),
  Lesson(
    title: "Lesson 2: Variables and Data Types",
    description:
        "This lesson covers variables and data types in C programming.",
    content: [
      // Content of the lesson
    ],
  ),
  // Add more lessons as needed
];

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
                MaterialPageRoute(
                  builder: (context) => LessonsPage(
                    lessons: lessonList,
                  ),
                ),
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

  Future<String?> _getUserDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        // Retrieve the user's name from the Firestore document
        final data = snapshot.data() as Map<String, dynamic>;
        final name = data['name'] as String?;
        return name;
      }
    }

    // User is not logged in or the name field is not available, return null
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
          FutureBuilder<String?>(
            future: _getUserDisplayName(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, show a loading indicator
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurred while fetching the display name, show an error message
                return Text('Error: ${snapshot.error}');
              } else {
                final displayName = snapshot.data;
                if (displayName != null) {
                  // User has a display name, display it
                  return Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                } else {
                  // User is not logged in or the display name is not available, display default text
                  return const Text(
                    'Unknown User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                }
              }
            },
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
