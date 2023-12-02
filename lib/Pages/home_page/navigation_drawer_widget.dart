import 'package:basicprog/constants/routes.dart';
import 'package:basicprog/pages/home_page/drawer_header_widget.dart';
import 'package:basicprog/pages/home_page/drawer_item_widget.dart';
import 'package:basicprog/provider/assessments_provider.dart';
import 'package:basicprog/provider/compiler_provider.dart';
import 'package:basicprog/provider/lessons_provider.dart';
import 'package:basicprog/provider/progress_provider.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
import 'package:basicprog/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

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
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
