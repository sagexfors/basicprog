import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Widgets/circle_thingy.dart';
import 'activities_page.dart';
import 'lessons_page.dart';
import 'profile_page.dart';
import 'quizzes_page.dart';

final List<Lesson> lessonList = [
  Lesson(
    title: "Lesson 1: Introduction to C Language",
    description: "An introduction to the C programming language.",
    content: [
      "What is Programming Language?",
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
      "10. Print Spoolers",
      "SUMMARY OF THE LESSON:",
      "1. Programming Language is a set of grammatical rules for instructing a computer or any computing device to perform specific tasks.",
      "2. The three categories of Programming Language are: Machine Language, Low-Level Language, and High-Level Language.",
      "3. There are three translator programs available in Programming Language, namely: Assembler, Interpreter, and Compiler.",
      "4. Dennis Ritchie founded the C language in 1972 at Bell Laboratories in American Telephone and Telegraph located in the United States of America.",
      "5. C Language can be defined as: Mother Language, System Programming Language, Procedural Programming Language, Structured Programming Language, and Mid-Level Programming Language.",
      "6. C Language was accepted as a system development language because it generates code that is nearly as fast as assembly code language.",
      "7. There are 5 steps in the execution flow of a C program: Preprocessor, Compiler, Assembler, Linker, and Loader."
    ],
  ),
  Lesson(
    title: "Lesson 2: C Language Program Structure and Elements",
    description:
        "Understanding the program structure and elements of the C programming language.",
    content: [
      "Program Structure",
      "A C Program basically consists of the following parts:",
      "1. Preprocessor Commands/Directives",
      "2. main() Function",
      "3. Statements & Expressions",
      "4. Comments",
      "Take a look at a simple code that will display the word “Hello C Language” on your display screen.",
      "#include <stdio.h>",
      "int main(){",
      "  /*my first program in C*/",
      "  printf(\"Hello C Language\");",
      "  return 0;",
      "}",
      "#include <stdio.h>",
      "• The first line of the program is a preprocessor command, which tells a Compiler to include stdio.h file before going to actual compilation. C commands are organized into libraries and .h is the extension name of the C libraries. stdio.h is the library that covers the input and output commands of C.",
      "int main(){",
      "• It is the main function where the program execution begins. It is the entry point of every program in C Language.",
      " /*my first program in C*/",
      "• What inside the /*…*/ will be ignored by the compiler and it has been put to add additional comments in the program. So, such lines are called comments in the program. You can use comments to remind the programmer of what the program/statement does.",
      "printf(\"Hello C Language\");",
      "• printf (…) is another function available in C which causes the message “Hello C Language” to be displayed on the screen. It is used to print data on the console.",
      "return 0;",
      "• The line return 0; terminated the program execution. Return execution status to the OS. The 0 value is used for successful execution and 1 for unsuccessful execution.",
      "Therefore, the basic C program structure is shown below:",
      "#preprocessor directives",
      "main()",
      "{",
      "  /*statements*/",
      "  printf(\"Hello C Language\");",
      "  return 0;",
      "}",
      "Note: Between the curly braces {} are the codes or statements that will be included in the program.",
      "Elements of C Language",
      "There are elements of programming that can be used in solving a problem with a programming language. These elements can be a guide in learning not only C language but also other programming languages, whether it be procedural or object-oriented programming languages. These are:",
      "1. Input/Output. These elements of computer programming allow interaction of the program with the external entities. Example of input/output element are printing something out the screen, capturing some text that the user input on the keyboard and can be included reading and writing files.",
      "2. Variables. Variables in programming tell how the data is represented, which can range from very simple value to complex ones. The value they contain can be changed depending on condition. As we know, a program consists of instructions that tell the computer to do things and data the program uses when it is running. Data is constant with fixed values or variable.",
      "3. Conditional. Conditionals specify the execution of the statements depending on whether the condition is satisfied or not. Basically, it refers to an action that only fulfills when the applied condition on instructions is satisfied. They are one of the most important components of the programming language because they give freedom to the program to act differently every time when it executes that depends on input to the instructions.",
      "4. Iterations. We can define a loop as a sequence of instructions that are repeated continuously until a certain condition is not satisfied. How a loop starts understanding this first a certain process is done to get any data and changing it after that applied condition on the loop is checked whether the counter reached the prescribed number or not. Basically, a loop carries out the execution of a group of instructions or commands a certain number of times. There is also a concept of an infinite loop which is also termed as an endless loop, a piece of code that lacks functional exit and goes to repeat indefinitely.",
      "5. Subroutines. This element of the programming allows a programmer to use a snippet of code in one location, which can be used over and over again. The primary purpose of functions is to take arguments in numbers of values and do some calculation on them, after that return a single result. Functions are required where you need to do complicated calculations, and the result of that may or may not be subsequently used in expressions.",
      "SUMMARY OF THE LESSON:",
      "1. A C program structure consists of preprocessor directives, main() function, statements, and comments.",
      "2. stdio.h is the standard input and output library of C.",
      "3. Comments are ignored by the compiler.",
      "4. {} are the indications of the beginning and end of the program.",
      "5. Elements of programming help to solve problems using programming languages.",
      "6. The basic elements of programming are: input, output, variables, conditional, iterations, and subroutines.",
      "7. Output is the most important element of programming.",
      "8. Input allows you to interact with the computer using input devices."
    ],
  ),
  Lesson(
    //lesson 4 should be
    title: "Lesson 3: C Language and Its Features",
    description: 'C Language',
    content: [
      "Dennis Ritchie created the structured programming language C in 1972 at Bell Laboratories. Its structure, high-level abstraction, and hardware independence make it one of the most widely used computer languages in use today.",
      "- C programming was first used to create the programs that make up the operating system. Assembly language, which is now used as a system development language, is almost as efficient as C when producing code.",
      "- Operating Systems (including the UNIX operating system and all UNIX applications), Language Compilers (including the C compiler), Assemblers, Text Editors, Print Spoolers, Network Drivers, Modern Programs, Databases, Language Interpreters, and Utilities are some examples of programs that utilize the C language.",
      "- Syntax of C",
      "  The syntax of a programming language is the set of rules you have to follow in order to write executable source code. Just like every other programming language, C has some syntactic idiosyncrasies that programmers should be aware of.",
      "  - Semicolons: Every statement ends with a semicolon in C, regardless of whether you’re calling a function or declaring a variable.",
      "  - Curly brackets: Sets of statements are marked with an opening and closing curly bracket in C. This means that indentation isn’t necessary, unlike in other programming languages, though it does aid significantly in making your code more readable.",
      "  - Integrating libraries: If you want to integrate a library in order to used pre-defined functions, you can use an include statement:"
    ],
  )
];

///quizzes
List<Question> questions = [
  Question(
    question:
        "It is the language that will serve as the medium between the human and the machine or the computer.",
    choices: [
      "C Language",
      "Software Programming",
      "Programming Language",
      "Execution Flow"
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question: "This language is used by the primitive machines.",
    choices: [
      "Procedural Programming Language",
      "Computer Programming Language",
      "Object-Oriented Programming Language",
      "Machine Language"
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    question: "These are categories of programming language, except:",
    choices: [
      "Machine Language",
      "High-level Language",
      "Low-level Language",
      "Computer Language"
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    question:
        "It is a way of writing a computer program which is using the idea of 'objects' to represent data and methods.",
    choices: [
      "System Programming Language",
      "Procedural Programming Language",
      "Object-Oriented Programming Language",
      "Mid-level Programming Language"
    ],
    correctAnswerIndex: 2,
  ),
];

final quizOne = Quiz(
  title: 'Quiz 1',
  description: 'Quiz for Lesson 1',
  questions: questions,
);

List<Question> questions2 = [
  Question(
    question:
        "It translates a program written in a high-level language into machine language. It scans the entire program and translates it as a whole into machine code. Programming languages that utilize compilers are C, C++, Java, VB.Net, etc.",
    choices: [
      "Assembler",
      "Compiler",
      "Translator",
      "Interpreter",
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question:
        "These are programs that are utilized by a particular programming language to translate instructions written either in a low-level language or a high-level language.",
    choices: [
      "Compiler",
      "Assembler",
      "Translator",
      "Interpreter",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question: "These are translators of a programming language, except:",
    choices: [
      "Assembler",
      "Compiler",
      "Computer",
      "Interpreter",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question:
        "It is referred to as the mother language since it forms the foundation for all other programming languages.",
    choices: [
      "C Language",
      "Java Programming Language",
      "Python",
      "Structured Programming Language",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question: "He was the founder of the C Language.",
    choices: [
      "Martin Richard",
      "Dennis Ritchie",
      "Ken Thompson",
      "Linux Kernel",
    ],
    correctAnswerIndex: 1,
  ),
];

Quiz quizTwo = Quiz(
  title: 'Quiz 2',
  description: 'Quiz for Lesson 1',
  questions: questions2,
);

List<Question> questions3 = [
  Question(
    question:
        "C programming language was developed in 1927 by Dennis Ritchie at Bell Laboratories at American Telephone & Telegraph (AT&T) located in the United States of America. He created the C programming language for building system applications that communicate directly with hardware components like kernels and drivers.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question:
        "Martin Richard created the C programming language for building system applications that communicate directly with hardware components like kernels and drivers.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question:
        "Bell Laboratories at Australian Telephone & Telegraph (AT&T) is located in the United States of America.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question:
        "C is considered as middle-level language because it supports the feature of both low-level and high-level languages. C language program is converted into assembly code, it supports pointer arithmetic (low-level), but it is machine independent (a feature of high-level).",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question:
        "C can be used to program for the internet like Java, .Net, PHP, etc.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 1,
  ),
];

Quiz quizThree = Quiz(
  title: 'Quiz 3',
  description: 'Quiz for Lesson 1',
  questions: questions3,
);

List<Question> questions4 = [
  Question(
    question: "A C program basically consists of following parts, except:",
    choices: [
      "Preprocessor Directives",
      "main() function",
      "expressions",
      "variables",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question: "The first line of the program ___ is a preprocessor command.",
    choices: [
      "/*...*/",
      "Int main()",
      "#include<stdio.h>",
      "Return 0;",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question: "It terminates the program execution.",
    choices: [
      "printf()",
      "/*...*/",
      "int main()",
      "return 0;",
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    question: "It is the main function where the program execution begins.",
    choices: [
      "int main()",
      "printf()",
      "/*...*/",
      "#include<stdio.h>",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question:
        "This element is used for comments that will be ignored by the compiler.",
    choices: [
      "/*...*/",
      "printf()",
    ],
    correctAnswerIndex: 0,
  ),
];

Quiz quizFour = Quiz(
  title: 'Quiz 4',
  description: 'Quiz for Lesson 2',
  questions: questions4,
);

List<Question> questions5 = [
  Question(
    question:
        "The primary purpose of the functions is to take arguments in numbers of values and do some calculation on them after that return a single result.",
    choices: [
      "Input",
      "Iterations",
      "Subroutines",
      "Conditional",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question:
        "In programming, it tells how the data is represented which can be range from very simple value to complex one.",
    choices: [
      "Output",
      "Variables",
      "Iterations",
      "Subroutines",
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question: "It is the most important element of the programming.",
    choices: [
      "{}",
      ";",
      "Input",
      "Output",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question: "These are the indication of the begin and end of the program.",
    choices: [
      "()",
      "/*...*/",
      "{}",
      ";",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question: "It is where set of instructions are repeated continuously.",
    choices: [
      "Subroutines",
      "Conditional",
      "Iterations",
      "Variables",
    ],
    correctAnswerIndex: 2,
  ),
];

Quiz quizFive = Quiz(
  title: 'Quiz 5',
  description: 'Quiz for Lesson 2',
  questions: questions5,
);

List<Question> questions6 = [
  Question(
    question:
        "The most complex elements of programming are: input, output, variables, conditional, iterations, and subroutines.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question:
        "Elements of programming help to solve problems using a programming language.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    question: "Comments are the standard input and output library of C.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question:
        "Between the braces () are the codes or statements that will be included in the program.",
    choices: [
      "True",
      "False",
    ],
    correctAnswerIndex: 1,
  ),
];

Quiz quizSix = Quiz(
  title: 'Quiz 6',
  description: 'Quiz for Lesson 2',
  questions: questions6,
);
final List<Quiz> quizzes = [
  quizOne,
  quizTwo,
  quizThree,
  quizFour,
  quizFive,
  quizSix
];

///
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 96),
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
      drawer: const NavigationDrawer(),
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
          const Divider(),
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
                MaterialPageRoute(
                  builder: (context) => QuizzesPage(
                    quizzes: quizzes,
                  ),
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
