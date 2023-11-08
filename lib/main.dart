import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//TODO: ADD CODE FOR THE TYPE CODE, AND ADD TABLE FOR THE TYPE TABLE.
//TODO: CLEAN UP THE COMPILER BY ADDING TABS
//TODO: FIX .JSON THE CODE  THINGY THAT IS MULTIPLE CONTENT

//TODO: COMPILER, ADD ERROR POP UP AND OUTPUT POP UP OR SCREEN?
//TODO: IF LOG OUT, SHOW SNACKBAR OR NOTIFICATION