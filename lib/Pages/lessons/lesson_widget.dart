import 'package:basicprog/Widgets/table_widget.dart';
import 'package:basicprog/model/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:highlight/languages/cpp.dart';

class LessonWidget extends StatelessWidget {
  final int lessonNumber;
  final Lesson lesson;

  const LessonWidget({
    super.key,
    required this.lessonNumber,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final title = lesson.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lesson.content.length,
              itemBuilder: (context, index) {
                final contentItem = lesson.content[index];
                final contentType = contentItem.type;
                final contentItemText = contentItem.text ?? '';
                final contentItemCode = contentItem.code ?? '';

                if (contentType == "text") {
                  return ParagraphWidget(contentItemText: contentItemText);
                } else if (contentType == "code") {
                  final controller = CodeController(
                    text: contentItemCode, // Initial co
                    language: cpp,
                  );
                  return StaticCodeEditor(controller: controller);
                } else if (contentType == "table") {
                  var tableData = contentItem.table ?? [];
                  return LessonTable(tableData: tableData);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LessonTable extends StatelessWidget {
  const LessonTable({
    super.key,
    required this.tableData,
  });

  final List<dynamic> tableData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: JsonTableWidget(
        tableData: tableData,
      ),
    );
  }
}

class StaticCodeEditor extends StatelessWidget {
  const StaticCodeEditor({
    super.key,
    required this.controller,
  });

  final CodeController controller;

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: defaultTheme),
      child: Column(
        children: [
          CodeField(
            controller: controller,
            // enabled: false,
            readOnly: true,
          ),
        ],
      ),
    );
  }
}

class ParagraphWidget extends StatelessWidget {
  const ParagraphWidget({
    super.key,
    required this.contentItemText,
  });

  final String contentItemText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        contentItemText,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
