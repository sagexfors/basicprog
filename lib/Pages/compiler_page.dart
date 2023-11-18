import 'package:basicprog/provider/compiler_provider.dart';
import 'package:basicprog/services/codexapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:provider/provider.dart';

class CompilerPage extends StatefulWidget {
  final String? code;
  const CompilerPage({super.key, this.code});

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage>
    with SingleTickerProviderStateMixin {
  late CodeController controller;
  late TabController _tabController;
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

    controller.addListener(() {
      String currentCode = controller.text;
      context.read<CompilerProvider>().code = currentCode;
    });

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> compileAndRun() async {
    var response = await CodexApiService.compileCode(
      controller.text,
      _inputController.text,
    );
    output = response['output'];
    error = response['error'];
    setState(() {
      if (output.isEmpty) {
        output = error;
        RegExp regex = RegExp(r"/app/codes/[0-9a-fA-F-]+.c:");
        output = output.replaceAll(regex, "");
      }
      _tabController.animateTo(2); // Switch to the output tab
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasError = error.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.code), text: "Code"),
            Tab(icon: Icon(Icons.input), text: "Input"),
            Tab(icon: Icon(Icons.output), text: "Output"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCodeEditorTab(),
          _buildInputTab(),
          _buildOutputTab(hasError),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: compileAndRun,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }

  Widget _buildCodeEditorTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CodeTheme(
          data: CodeThemeData(styles: defaultTheme),
          child: CodeField(
            controller: controller,
            minLines: 22,
            maxLines: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _inputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input arguments (leave blank if none)',
          ),
          minLines: 5,
          maxLines: 15,
        ),
      ),
    );
  }

  Widget _buildOutputTab(bool hasError) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Output:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (output.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hasError ? Colors.red.shade100 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  output,
                  style: TextStyle(
                    color: hasError ? Colors.red : Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
