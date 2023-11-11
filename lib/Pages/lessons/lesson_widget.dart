import 'package:basicprog/Widgets/table_widget.dart';
import 'package:basicprog/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/cpp.dart';

import 'package:flutter_highlight/themes/monokai-sublime.dart';

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
    var title = lesson.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
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
              itemCount: lesson.content?.length,
              itemBuilder: (context, index) {
                final contentItem = lesson.content?[index];
                final contentType = contentItem?.type;
                final contentItemText = contentItem?.text ?? '';

                if (contentType == "text") {
                  // Render a Text widget for "text" type
                  return ListTile(
                    title: Text(
                      contentItemText,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (contentType == "code") {
                  final controller = CodeController(
                    text: '', // Initial co
                    language: cpp,
                  );
                  controller.text = contentItemText;
                  return CodeTheme(
                    data: CodeThemeData(styles: monokaiSublimeTheme),
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
                } else if (contentType == "table") {
                  List<dynamic> tableData = contentItem?.table ?? [];
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: JsonTableWidget(data: tableData),
                  );
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
