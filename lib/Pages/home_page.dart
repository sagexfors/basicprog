import 'dart:convert';

import 'package:basicprog/model/lesson.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/circle_thingy.dart';
import '../model/temp_repository.dart';

import 'lessons_page.dart';

import 'quizzes_page.dart';

Future<List<Lesson>> parseLessonsFromJsonFile() async {
  // Read the JSON file into a String
  final jsonString =
      await rootBundle.loadString('assets/temp_repo_lessons.json');

  // Parse the JSON data
  final jsonData = await json.decode(jsonString);

  // Extract and parse lessons
  final lessonsData = jsonData['lessons'] as List<dynamic>;
  final lessons = lessonsData.map((lessonData) {
    final contentData = lessonData['content'] as List<dynamic>;
    final content = contentData.map((contentItem) {
      if (contentItem['type'] == 'text') {
        return Content(type: 'text', text: contentItem['text']);
      } else if (contentItem['type'] == 'code') {
        return Content(type: 'code', text: contentItem['code']);
      }
      return Content(type: 'text', text: '');
    }).toList();
    return Lesson(
      title: lessonData['title'],
      description: lessonData['description'],
      content: content,
    );
  }).toList();
  return lessons;
}

///
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 160),
                  Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome to Basic',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 90, 96, 179),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      '"The art of programming is the skill of controlling complexity." -Marijn Haverbeke',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
            const Positioned(
              top: -80,
              left: -100,
              child: CircleThing(opacity: 0.7),
            ),
            const Positioned(
              top: -140,
              left: -10,
              child: CircleThing(opacity: 0.7),
            ),

            // LoginForm(showRegisterPage: widget.showRegisterPage)
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: 'Lessons',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video,
            ),
            label: 'Activities',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed('/profile');
          }
        },
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
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          const Divider(),
          DrawerItemWidget(
            icon: Icons.book,
            title: 'Lessons',
            onTap: () async {
              var lessonList = await parseLessonsFromJsonFile();
              if (!context.mounted) return;
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
              Navigator.of(context).pushNamed('/activities');
            },
          ),
          DrawerItemWidget(
            icon: Icons.quiz,
            title: 'Quizzes',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizzesPage(
                    quizzes: quizzes,
                  ),
                ),
              );
            },
          ),
          DrawerItemWidget(
            icon: Icons.computer,
            title: 'Code Editor',
            onTap: () {
              Navigator.of(context).pushNamed('/compiler');
            },
          ),
          const Divider(),
          DrawerItemWidget(
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              Navigator.of(context).pushNamed('/about-us');
            },
          ),
          DrawerItemWidget(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
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
