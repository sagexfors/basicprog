import 'package:basicprog/model/question.dart';
import 'package:basicprog/model/quiz.dart';

///quizzes
List<Question> questions = [
  Question(
    question:
        "It is the language that will serve as the medium between the human and the machine or the computer.",
    choices: [
      "C Language",
      "Software Programming",
      "Programming Language",
      "Execution Flow",
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    question: "This language is used by the primitive machines.",
    choices: [
      "Procedural Programming Language",
      "Computer Programming Language",
      "Object-Oriented Programming Language",
      "Machine Language",
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    question: "These are categories of programming language, except:",
    choices: [
      "Machine Language",
      "High-level Language",
      "Low-level Language",
      "Computer Language",
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
      "Mid-level Programming Language",
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
  quizSix,
];
