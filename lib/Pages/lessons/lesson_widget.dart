import 'package:basicprog/Widgets/table_widget.dart';
import 'package:basicprog/model/lesson/lesson.dart';
import 'package:basicprog/provider/lessons_provider.dart';
import 'package:basicprog/provider/progress_provider.dart';
import 'package:basicprog/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:provider/provider.dart';

class LessonWidget extends StatefulWidget {
  final int lessonNumber;
  final Lesson lesson;
  final bool completed;

  const LessonWidget({
    super.key,
    required this.lessonNumber,
    required this.lesson,
    required this.completed,
  });

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  @override
  Widget build(BuildContext context) {
    final title = widget.lesson.title;
    final lessonsProvider = context.watch<LessonsProvider>();
    final completed =
        lessonsProvider.completedLessons[widget.lesson.id.toString()] ?? false;
    final progressProvider = context.read<ProgressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Checkbox(
            value: completed,
            onChanged: (bool? newValue) async {
              if (newValue != null) {
                lessonsProvider.toggleLessonCompletion(
                  widget.lesson.id.toString(),
                  newValue,
                );

                // Update the lesson's read status in Firestore
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                await userProvider.markLessonReadOrUnread(
                  widget.lesson.id.toString(),
                  newValue,
                );

                progressProvider.fetchLessonsProgress();
              }
            },
            // Material 3 style
            fillColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected)
                  ? Theme.of(context).colorScheme.secondary
                  : null,
            ),
            checkColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
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
                  for (var contentItem in widget.lesson.content) ...[
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
