import 'package:basicprog/services/codexapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:highlight/languages/cpp.dart';

class CompilerPage extends StatefulWidget {
  final String? code;
  const CompilerPage({super.key, this.code});

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  final controller = CodeController(
    text: '''
#include <stdio.h>

int main() {
    printf("Hello, World!");
    return 0;
}
''', // Initial co
    language: cpp,
  );

  var output = '';
  var error = '';

  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.code != null) {
      controller.text = widget.code!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
      ),
      body: Center(
        child: CodeTheme(
          data: CodeThemeData(styles: androidstudioTheme),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CodeField(
                  controller: controller,
                  minLines: 22,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                  child: TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      hintText: 'Input arguments (leave blank if none)',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Output: $output'),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await CodexApiService.compileCode(
            controller.text,
            _inputController.text,
          );
          output = response['output'];
          error = response['error'];
          setState(() {
            if (output == '') {
              output = error;
            }
          });
        },
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}


//TODO: ADD TAB WITH OUTPUT  RESULT and proper error display