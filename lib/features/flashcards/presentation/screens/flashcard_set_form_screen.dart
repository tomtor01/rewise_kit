import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/flashcard_set.dart';
import '../../domain/usecases/create_flashcard_set_usecase.dart';
import '../../../../core/services/injection_container.dart';
import '../app/controllers/flashcard_notifier.dart';

class FlashcardSetFormScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final FlashcardSet? flashcardSet;

  const FlashcardSetFormScreen({
    super.key,
    required this.lessonId,
    this.flashcardSet,
  });

  @override
  ConsumerState<FlashcardSetFormScreen> createState() => _FlashcardSetFormScreenState();
}

class _FlashcardSetFormScreenState extends ConsumerState<FlashcardSetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;

  bool get isEditing => widget.flashcardSet != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.flashcardSet?.title ?? '');
    _descriptionController = TextEditingController(text: widget.flashcardSet?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edytuj zestaw fiszek' : 'Utwórz zestaw fiszek'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveFlashcardSet,
            child: _isSaving
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Text('ZAPISZ'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Tytuł zestawu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tytuł zestawu jest wymagany';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Opis (opcjonalny)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveFlashcardSet,
                icon: _isSaving
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : Icon(isEditing ? Icons.save : Icons.add),
                label: Text(_isSaving
                    ? (isEditing ? 'Zapisywanie...' : 'Tworzenie...')
                    : (isEditing ? 'Zapisz zmiany' : 'Utwórz zestaw')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveFlashcardSet() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSaving = true);

      try {
        if (!isEditing) {
          final createUseCase = sl<CreateFlashcardSetUseCase>();
          final result = await createUseCase(
            CreateFlashcardSetParams(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim(),
              lessonId: widget.lessonId,
            ),
          );

          result.fold(
                (failure) => throw Exception(failure.message),
                (_) {},
          );
        }

        if (mounted) {
          context.pop();

          ref.invalidate(flashcardSetsByLessonProvider(widget.lessonId));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isEditing
                  ? 'Zestaw fiszek został zaktualizowany'
                  : 'Zestaw fiszek został utworzony'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isEditing
                  ? 'Błąd podczas aktualizacji zestawu: $error'
                  : 'Błąd podczas tworzenia zestawu: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}