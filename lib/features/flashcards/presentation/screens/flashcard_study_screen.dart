import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/services/flashcard_study_state.dart';
import '../app/controllers/flashcard_notifier.dart';
import '../widgets/flashcard_card.dart';

class FlashcardStudyScreen extends ConsumerStatefulWidget {
  final String flashcardSetId;

  const FlashcardStudyScreen({
    super.key,
    required this.flashcardSetId,
  });

  @override
  ConsumerState<FlashcardStudyScreen> createState() => _FlashcardStudyScreenState();
}

class _FlashcardStudyScreenState extends ConsumerState<FlashcardStudyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(flashcardStudyProvider.notifier)
          .initializeStudySession(widget.flashcardSetId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flashcardStudyProvider);
    final notifier = ref.read(flashcardStudyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nauka z fiszkami'),
        actions: [
          if (state.flashcards.isNotEmpty) ...[
            IconButton(
              onPressed: () => _showOptionsMenu(context, notifier),
              icon: const Icon(Icons.more_vert),
              tooltip: 'Opcje',
            ),
          ],
        ],
      ),
      body: _buildBody(state, notifier),
      bottomNavigationBar: state.flashcards.isNotEmpty
          ? _buildBottomBar(state, notifier)
          : null,
    );
  }

  Widget _buildBody(FlashcardStudyState state, FlashcardStudy notifier) {
    if (state.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Ładowanie fiszek...'),
          ],
        ),
      );
    }

    if (state.error != null) {
      return Center(
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
              'Wystąpił błąd',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => notifier.initializeStudySession(widget.flashcardSetId),
              child: const Text('Spróbuj ponownie'),
            ),
          ],
        ),
      );
    }

    if (state.flashcards.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Brak fiszek',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Ten zestaw nie zawiera jeszcze żadnych fiszek.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.isSessionComplete) {
      return _buildSessionCompleteView(state, notifier);
    }

    final currentFlashcard = notifier.currentFlashcard!;

    return Column(
      children: [
        // Progress bar
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${state.currentIndex + 1} / ${state.flashcards.length}'),
                  Text('${notifier.progress}%'),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (state.currentIndex + 1) / state.flashcards.length,
                backgroundColor: Colors.grey[300],
              ),
            ],
          ),
        ),

        // Flashcard
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FlashcardCard(
              flashcard: currentFlashcard,
              isRevealed: state.isRevealed,
              onTap: () => notifier.revealAnswer(),
            ),
          ),
        ),

        // Action buttons
        if (state.isRevealed) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => notifier.markFlashcard(false),
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: const Text('Nie znam'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => notifier.markFlashcard(true),
                    icon: const Icon(Icons.check, color: Colors.green),
                    label: const Text('Znam'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBottomBar(FlashcardStudyState state, FlashcardStudy notifier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: notifier.hasPrevious ? () => notifier.previousFlashcard() : null,
            icon: const Icon(Icons.arrow_back_ios),
            tooltip: 'Poprzednia fiszka',
          ),
          Text(
            '${state.currentIndex + 1} / ${state.flashcards.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            onPressed: notifier.hasNext ? () => notifier.nextFlashcard() : null,
            icon: const Icon(Icons.arrow_forward_ios),
            tooltip: 'Następna fiszka',
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, FlashcardStudy notifier) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.shuffle),
              title: const Text('Wymieszaj fiszki'),
              onTap: () {
                Navigator.pop(context);
                notifier.shuffleFlashcards();
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Zacznij od nowa'),
              onTap: () {
                Navigator.pop(context);
                notifier.resetSession();
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Przejdź do fiszki'),
              onTap: () {
                Navigator.pop(context);
                _showFlashcardSelector(context, notifier);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFlashcardSelector(BuildContext context, FlashcardStudy notifier) {
    final state = ref.read(flashcardStudyProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wybierz fiszkę'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: state.flashcards.length,
            itemBuilder: (context, index) {
              final flashcard = state.flashcards[index];
              final isSelected = index == state.currentIndex;

              return ListTile(
                selected: isSelected,
                leading: CircleAvatar(
                  backgroundColor: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  flashcard.front,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.pop(context);
                  notifier.goToFlashcard(index);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCompleteView(FlashcardStudyState state, FlashcardStudy notifier) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Gratulacje!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ukończyłeś sesję nauki',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Zapamiętano:',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('${state.correctAnswers}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Do nauki:',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('${state.incorrectAnswers}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                if (state.incorrectAnswers > 0) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => notifier.startIncorrectOnly(),
                      icon: const Icon(Icons.replay),
                      label: Text('Powtórz niezapamiętane (${state.incorrectAnswers})'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => notifier.resetSession(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Powtórz całą sesję'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      notifier.shuffleFlashcards();
                      notifier.resetSession();
                    },
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Powtórz z wymieszaniem'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Powrót do zestawów'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}