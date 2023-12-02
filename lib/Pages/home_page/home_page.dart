import 'package:basicprog/constants/routes.dart';
import 'package:basicprog/pages/home_page/navigation_drawer_widget.dart';
import 'package:basicprog/provider/progress_provider.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../Widgets/circle_thingy.dart';

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
      drawer: const NavigationDrawerWidget(),
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
