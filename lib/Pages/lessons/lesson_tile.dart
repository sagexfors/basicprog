import 'package:basicprog/model/lesson/lesson.dart';
import 'package:basicprog/pages/lessons/lesson_widget.dart';
import 'package:flutter/material.dart';

class LessonTile extends StatelessWidget {
  final int lessonNumber;
  final Lesson lesson;
  final bool completed;

  const LessonTile({
    super.key,
    required this.lessonNumber,
    required this.lesson,
    required this.completed, // Add the completed parameter
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LessonWidget(
                  lessonNumber: lessonNumber,
                  lesson: lesson,
                  completed: completed, // Pass the completed parameter
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeading(theme),
                const SizedBox(width: 16),
                Expanded(child: _buildLessonInfo(theme)),
                _buildCompletionIndicator(theme), // Add completion indicator
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(ThemeData theme) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Icon(
          Icons.menu_book, // Education-related icon
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLessonInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lesson.title,
          style: theme.textTheme.titleLarge,
          maxLines: 3,
          overflow: TextOverflow.visible,
        ),
        const SizedBox(height: 8),
        Text(
          lesson.description,
          style: theme.textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildCompletionIndicator(ThemeData theme) {
    return Icon(
      completed ? Icons.check_circle : Icons.radio_button_unchecked,
      color:
          completed ? theme.colorScheme.primary : theme.colorScheme.onSurface,
      size: 24,
    );
  }
}
