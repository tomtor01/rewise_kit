import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final lessonDetailsAsync = ref.watch(
      lessonDetailsProvider(widget.lessonId),
    );
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
                  if (isCreator)
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'delete') {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Usunąć lekcję?'),
                                  content: const Text(
                                    'Tej operacji nie można cofnąć. Czy na pewno chcesz trwale usunąć tę lekcję?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () =>
                                              Navigator.of(context).pop(false),
                                      child: const Text('Anuluj'),
                                    ),
                                    FilledButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(true),
                                      child: const Text('Usuń'),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm == true && mounted) {
                            await ref
                                .read(lessonActionsProvider.notifier)
                                .deleteLesson(widget.lessonId);

                            if (mounted) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Usunięto lekcję "${lesson.title}"',
                                    ),
                                  ),
                                );
                              context.pop();
                            }
                          }
                        }
                      },
                      itemBuilder:
                          (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete_outline),
                                title: Text('Usuń lekcję'),
                              ),
                            ),
                          ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSaved
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest
                                  : Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              isSaved
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant
                                  : Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed:
                            _isProcessing
                                ? null
                                : () async {
                                  final lessonActions = ref.read(
                                    lessonActionsProvider.notifier,
                                  );

                                  if (isSaved) {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: const Text(
                                              'Przestać obserwować?',
                                            ),
                                            content: const Text(
                                              'Czy na pewno chcesz usunąć tę lekcję z obserwowanych?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.of(
                                                      context,
                                                    ).pop(false),
                                                child: const Text('Anuluj'),
                                              ),
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.of(
                                                      context,
                                                    ).pop(true),
                                                child: const Text('Potwierdź'),
                                              ),
                                            ],
                                          ),
                                    );

                                    if (confirm == true) {
                                      setState(() => _isProcessing = true);
                                      await lessonActions.unsaveLesson(
                                        lesson.id,
                                      );
                                    }
                                  } else {
                                    setState(() => _isProcessing = true);
                                    await lessonActions.saveLesson(lesson.id);
                                  }

                                  if (mounted) {
                                    setState(() => _isProcessing = false);
                                  }
                                },
                        child:
                            _isProcessing
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
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
                    const SizedBox(height: 24),
                    // Sekcja zestawów fiszek
                    Row(
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Zestawy fiszek',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Tutaj będzie lista zestawów fiszek
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.quiz),
                        title: const Text('Przejdź do zestawów fiszek'),
                        subtitle: const Text('Przeglądaj i ucz się z fiszkami'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.push(
                            '/lesson/${widget.lessonId}/flashcards?isCreator=$isCreator',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(child: Text('Wystąpił błąd: $error')),
      ),
      floatingActionButton: lessonDetailsAsync.when(
        data: (lesson) {
          final currentUser = ref.watch(currentUserProvider);
          final isCreator = currentUser?.uid == lesson.creatorId;

          return isCreator
              ? FloatingActionButton(
                onPressed: () {
                  context.push(
                    '/lesson/${widget.lessonId}/flashcards?isCreator=true',
                  );
                },
                tooltip: 'Zarządzaj zestawami fiszek',
                child: const Icon(Icons.quiz),
              )
              : null;
        },
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }
}
