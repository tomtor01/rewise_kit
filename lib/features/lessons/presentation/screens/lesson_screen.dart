import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewise_kit/features/lessons/presentation/app/providers/lesson_provider.dart';

class LessonScreen extends ConsumerWidget {
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonDetailsAsync = ref.watch(lessonDetailsProvider(lessonId));

    return Scaffold(
      body: lessonDetailsAsync.when(
        data: (lesson) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(lesson.title),
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList.list(
                  children: [
                    Text(
                      'Autor: ${lesson.creatorId}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      lesson.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // Tutaj w przyszłości będzie lista fiszek
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Wystąpił błąd: $error'),
        ),
      ),
    );
  }
}
