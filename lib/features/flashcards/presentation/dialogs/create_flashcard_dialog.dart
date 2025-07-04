import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/controllers/flashcard_notifier.dart';
import '../../domain/entities/flashcard.dart';

class CreateFlashcardDialog extends ConsumerStatefulWidget {
  final String flashcardSetId;
  final VoidCallback onCreated;
  final Flashcard? existingFlashcard; // Dodane pole

  const CreateFlashcardDialog({
    super.key,
    required this.flashcardSetId,
    required this.onCreated,
    this.existingFlashcard, // Opcjonalna fiszka do edycji
  });

  @override
  ConsumerState<CreateFlashcardDialog> createState() =>
      _CreateFlashcardDialogState();
}

class _CreateFlashcardDialogState extends ConsumerState<CreateFlashcardDialog> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get isEditing => widget.existingFlashcard != null;

  @override
  void initState() {
    super.initState();
    // Jeśli edytuje, wypełnia pola
    if (isEditing) {
      questionController.text = widget.existingFlashcard!.front;
      answerController.text = widget.existingFlashcard!.back;
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edytuj fiszkę' : 'Utwórz fiszkę',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveFlashcard,
            child: Text(isEditing ? 'Zapisz' : 'Utwórz'),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Przód fiszki',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: questionController,
                      decoration: InputDecoration(
                        hintText: 'Wpisz pytanie lub pojęcie...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Treść przodu jest wymagana';
                        }
                        return null;
                      },
                      maxLines: 3,
                      minLines: 2,
                      maxLength: 50,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tył fiszki',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: answerController,
                      decoration: InputDecoration(
                        hintText: 'Wpisz odpowiedź lub definicję...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Treść tyłu jest wymagana';
                        }
                        return null;
                      },
                      maxLines: 5,
                      minLines: 3,
                      maxLength: 200,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveFlashcard() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        if (isEditing) {
          // Edytuj istniejącą fiszkę
          await ref.read(flashcardActionsProvider.notifier).updateFlashcard(
            widget.existingFlashcard!.id,
            questionController.text.trim(),
            answerController.text.trim(),
          );
        } else {
          // Utwórz nową fiszkę
          await ref.read(flashcardActionsProvider.notifier).createFlashcard(
            questionController.text.trim(),
            answerController.text.trim(),
            widget.flashcardSetId,
          );
        }

        if (mounted) {
          Navigator.pop(context);
          widget.onCreated();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? 'Fiszka została zaktualizowana'
                    : 'Fiszka została utworzona',
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? 'Błąd podczas aktualizacji: $error'
                    : 'Błąd podczas tworzenia fiszki: $error',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }
}