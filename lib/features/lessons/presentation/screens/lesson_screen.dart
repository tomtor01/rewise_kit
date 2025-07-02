import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewise_kit/core/common/providers/current_user_provider.dart';
import 'package:rewise_kit/features/dashboard/presentation/app/notifiers/user_data_notifier.dart';
import 'package:rewise_kit/features/lessons/presentation/app/notifiers/lesson_notifier.dart';
import 'package:rewise_kit/features/lessons/presentation/app/providers/lesson_provider.dart';

class LessonScreen extends ConsumerStatefulWidget {
  final String lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final lessonDetailsAsync = ref.watch(lessonDetailsProvider(widget.lessonId));
    final userDataAsync = ref.watch(userDataNotifierProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      body: lessonDetailsAsync.when(
        data: (lesson) {
          final isSaved =
              userDataAsync.value?.savedLessonIds.contains(lesson.id) ?? false;
          final isCreator = currentUser?.uid == lesson.creatorId;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(lesson.title),
                pinned: true,
                actions: [
                  // Jeśli użytkownik nie jest twórcą, pokaż przycisk
                  if (!isCreator)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSaved
                              ? Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              : Theme.of(context).colorScheme.primary,
                          foregroundColor: isSaved
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: _isProcessing
                            ? null
                            : () async {
                          final lessonActions =
                          ref.read(lessonActionsProvider.notifier);

                          if (isSaved) {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                const Text('Przestać obserwować?'),
                                content: const Text(
                                  'Czy na pewno chcesz usunąć tę lekcję z obserwowanych?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Anuluj'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Potwierdź'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              setState(() => _isProcessing = true);
                              await lessonActions.unsaveLesson(lesson.id);
                            }
                          } else {
                            setState(() => _isProcessing = true);
                            await lessonActions.saveLesson(lesson.id);
                          }

                          if (mounted) {
                            setState(() => _isProcessing = false);
                          }
                        },
                        child: _isProcessing
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : Text(isSaved ? 'Obserwujesz' : 'Obserwuj'),
                      ),
                    ),
                ],
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
        error: (error, stackTrace) =>
            Center(child: Text('Wystąpił błąd: $error')),
      ),
    );
  }
}