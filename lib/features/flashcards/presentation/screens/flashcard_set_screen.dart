import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../app/controllers/flashcard_notifier.dart';
import '../widgets/flashcard_set_card.dart';

class FlashcardSetScreen extends ConsumerWidget {
  final String lessonId;
  final bool isCreator;

  const FlashcardSetScreen({
    super.key,
    required this.lessonId,
    required this.isCreator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcardSetsAsync = ref.watch(
      flashcardSetsByLessonProvider(lessonId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Zestawy fiszek')),
      body: flashcardSetsAsync.when(
        data: (flashcardSets) {
          if (flashcardSets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.quiz_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Brak zestawów fiszek',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isCreator
                        ? 'Utwórz pierwszy zestaw fiszek dla tej lekcji'
                        : 'Ta lekcja nie zawiera jeszcze zestawów fiszek',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (isCreator) ...[
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _navigateToCreateFlashcardSet(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Utwórz zestaw fiszek'),
                    ),
                  ],
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh:
                () =>
                    ref.refresh(flashcardSetsByLessonProvider(lessonId).future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: flashcardSets.length,
              itemBuilder: (context, index) {
                final flashcardSet = flashcardSets[index];
                return FlashcardSetCard(
                  flashcardSet: flashcardSet,
                  onTap: () {
                    context.push('/flashcard-set/${flashcardSet.id}/study');
                  },
                  onManage:
                      isCreator
                          ? () => _navigateToManageFlashcards(
                            context,
                            flashcardSet.id,
                          )
                          : null,
                  isCreator: isCreator,
                  onDelete:
                      isCreator
                          ? (setId) => _deleteFlashcardSet(context, ref, setId)
                          : null,
                );
              },
            ),
          );
        },
        loading:
            () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Ładowanie zestawów fiszek...'),
                ],
              ),
            ),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Błąd podczas ładowania',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => ref.refresh(
                          flashcardSetsByLessonProvider(lessonId).future,
                        ),
                    child: const Text('Spróbuj ponownie'),
                  ),
                ],
              ),
            ),
      ),
      floatingActionButton:
          isCreator
              ? FloatingActionButton(
                onPressed: () => _navigateToCreateFlashcardSet(context),
                tooltip: 'Utwórz nowy zestaw fiszek',
                child: const Icon(Icons.add),
              )
              : null,
    );
  }

  void _navigateToCreateFlashcardSet(BuildContext context) {
    context.push('/lesson/$lessonId/flashcards/create');
  }

  void _navigateToManageFlashcards(
    BuildContext context,
    String flashcardSetId,
  ) {
    context.push('/flashcard-set/$flashcardSetId/manage');
  }

  Future<void> _deleteFlashcardSet(
    BuildContext context,
    WidgetRef ref,
    String setId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Usuń zestaw fiszek'),
            content: const Text(
              'Czy na pewno chcesz usunąć ten zestaw fiszek? Tej operacji nie można cofnąć.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Anuluj'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Usuń'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      try {
        // TODO: Dodaj DeleteFlashcardSetUseCase gdy będzie gotowy
        // await ref.read(flashcardSetActionsProvider.notifier).deleteFlashcardSet(setId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Zestaw fiszek został usunięty'),
              backgroundColor: Colors.green,
            ),
          );
          // Odśwież listę
          ref.invalidate(flashcardSetsByLessonProvider(lessonId));
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Błąd podczas usuwania: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
