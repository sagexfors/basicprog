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
    final theme = Theme.of(context);
    final title = lesson.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var contentItem in lesson.content) ...[
                    _buildContentItem(contentItem, context),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem(
    var contentItem,
    BuildContext context,
  ) {
    final contentType = contentItem.type;
    final contentItemText = contentItem.text ?? '';
    final contentItemCode = contentItem.code ?? '';

    switch (contentType) {
      case "text":
        return _ParagraphWidget(contentItemText: contentItemText);
      case "code":
        final controller = CodeController(
          text: contentItemCode,
          language: cpp,
        );
        return _StaticCodeEditor(controller: controller);
      case "table":
        var tableData = contentItem.table ?? [];
        return _LessonTable(tableData: tableData);
      default:
        return const SizedBox();
    }
  }
}

class _LessonTable extends StatelessWidget {
  final List<dynamic> tableData;

  const _LessonTable({
    required this.tableData,
  });

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

class _StaticCodeEditor extends StatelessWidget {
  final CodeController controller;

  const _StaticCodeEditor({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: defaultTheme),
      child: CodeField(
        controller: controller,
        readOnly: true,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}

class _ParagraphWidget extends StatelessWidget {
  final String contentItemText;

  const _ParagraphWidget({
    required this.contentItemText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      contentItemText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
    );
  }
}
