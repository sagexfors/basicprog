//create compilere provider
// that holds the current code in editor
// so that even after switching between pages
// the code in editor is not lost

import 'package:flutter/material.dart';

class CompilerProvider extends ChangeNotifier {
  String _code = '''
#include <stdio.h>

int main() {
    printf("Hello, World!");
    return 0;
}
''';

  String get code => _code;

  set code(String code) {
    _code = code;
    notifyListeners();
  }
}
