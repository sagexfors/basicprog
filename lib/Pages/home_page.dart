import 'package:basicprog/constants/routes.dart';
import 'package:basicprog/provider/assessments_provider.dart';
import 'package:basicprog/provider/compiler_provider.dart';
import 'package:basicprog/provider/lessons_provider.dart';
import 'package:basicprog/provider/progress_provider.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
import 'package:basicprog/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Widgets/circle_thingy.dart';

///
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProgressProvider>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final lessonsProgress = progressProvider.lessonsProgress;
    final quizzesProgress = progressProvider.quizzesProgress;
    final assessmentsProgress = progressProvider.assessmentsProgress;
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
                  const SizedBox(height: 120),
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
                  const SizedBox(height: 400),
                ],
              ),
            ),
            Positioned(
              top: 340,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(lessonsRoute);
                    },
                    child: const Text(
                      'Lessons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearPercentIndicator(
                    width: 390,
                    lineHeight: 30.0,
                    percent: lessonsProgress,
                    center:
                        Text("${(lessonsProgress * 100).toInt().toString()} %"),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(quizzesRoute);
                    },
                    child: const Text(
                      'Quizzes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearPercentIndicator(
                    width: 390,
                    lineHeight: 30.0,
                    percent: quizzesProgress,
                    center:
                        Text("${(quizzesProgress * 100).toInt().toString()} %"),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(assessmentsRoute);
                    },
                    child: const Text(
                      'Assessment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearPercentIndicator(
                    width: 390,
                    lineHeight: 30.0,
                    percent: assessmentsProgress,
                    center: Text(
                      "${(assessmentsProgress * 100).toInt().toString()} %",
                    ),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
            const Positioned(
              top: -80,
              left: -100,
              child: CircleThing(opacity: 0.3),
            ),
            const Positioned(
              top: -140,
              left: -10,
              child: CircleThing(opacity: 0.4),
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
              Icons.computer,
            ),
            label: 'Code Editor',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed(lessonsRoute);
          }
          if (index == 2) {
            Navigator.of(context).pushNamed(compilerRoute);
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
            onTap: () async {
              await Navigator.of(context).pushNamed(profileRoute);
            },
          ),
          const Divider(),
          DrawerItemWidget(
            icon: Icons.book,
            title: 'Lessons',
            onTap: () async {
              await Navigator.of(context).pushNamed(lessonsRoute);
            },
          ),
          DrawerItemWidget(
            icon: Icons.quiz,
            title: 'Quizzes',
            onTap: () async {
              await Navigator.of(context).pushNamed(quizzesRoute);
            },
          ),
          DrawerItemWidget(
            icon: Icons.assessment,
            title: 'Assessment',
            onTap: () async {
              await Navigator.of(context).pushNamed(assessmentsRoute);
            },
          ),
          DrawerItemWidget(
            icon: Icons.computer,
            title: 'Code Editor',
            onTap: () async {
              await Navigator.of(context).pushNamed(compilerRoute);
            },
          ),
          const Divider(),
          DrawerItemWidget(
            icon: Icons.info,
            title: 'About Us',
            onTap: () async {
              await Navigator.of(context).pushNamed(aboutUsRoute);
            },
          ),
          DrawerItemWidget(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              if (!context.mounted) return;
              Provider.of<UserProvider>(context, listen: false).clear();
              Provider.of<AssessmentsProvider>(context, listen: false).clear();
              Provider.of<QuizzesProvider>(context, listen: false).clear();
              Provider.of<CompilerProvider>(context, listen: false).clear();
              Provider.of<LessonsProvider>(context, listen: false).clear();
              Provider.of<ProgressProvider>(context, listen: false).clear();
              await FirebaseAuth.instance.signOut();
              SnackBar snackBar = const SnackBar(
                content: Text('Logged out successfully!'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    final color = Theme.of(context).primaryColor;
    return DrawerHeader(
      decoration: BoxDecoration(
        color: color,
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
