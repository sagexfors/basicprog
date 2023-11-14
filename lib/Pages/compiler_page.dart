import 'package:basicprog/provider/compiler_provider.dart';
import 'package:basicprog/services/codexapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:provider/provider.dart';

class CompilerPage extends StatefulWidget {
  final String? code;
  const CompilerPage({super.key, this.code});

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  late CodeController controller;
  var output = '';
  var error = '';
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    String initialCode = widget.code ?? context.read<CompilerProvider>().code;
    controller = CodeController(
      text: initialCode,
      language: cpp,
    );

    // Adding a listener to the CodeController
    controller.addListener(() {
      // This function gets called every time the text changes
      String currentCode = controller.text;
      context.read<CompilerProvider>().code = currentCode;
    });
  }

  @override
  void dispose() {
    // Don't forget to dispose the controller
    controller.dispose();
    super.dispose();
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
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Output:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    output,
                  ),
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
              RegExp regex = RegExp(r"/app/codes/[0-9a-fA-F-]+.c:");
              output = output.replaceAll(regex, "");
            }
          });
        },
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}


//TODO: ADD TAB WITH OUTPUT  RESULT and proper error display