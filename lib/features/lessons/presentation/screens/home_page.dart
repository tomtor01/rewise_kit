import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rewise_kit/core/widgets/responsive_layout.dart';
import 'package:rewise_kit/features/lessons/domain/entities/lesson.dart';
import 'package:rewise_kit/features/lessons/presentation/app/notifiers/lesson_notifier.dart';
import 'package:rewise_kit/features/lessons/presentation/app/providers/lesson_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsyncValue = ref.watch(filteredLessonsProvider);
    final currentFilter = ref.watch(currentLessonFilterProvider);
    final windowSizeClass = ResponsiveLayout.getWindowSizeClass(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Szukaj lekcji...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    ref.read(lessonSearchQueryProvider.notifier).setQuery(query);
                  },
                ),
                const SizedBox(height: 16),
                SegmentedButton<LessonFilter>(
                  segments: const <ButtonSegment<LessonFilter>>[
                    ButtonSegment(value: LessonFilter.all, label: Text('Wszystkie')),
                    ButtonSegment(value: LessonFilter.created, label: Text('Utworzone')),
                    ButtonSegment(value: LessonFilter.saved, label: Text('Zapisane')),
                  ],
                  selected: {currentFilter},
                  onSelectionChanged: (newSelection) {
                    ref.read(currentLessonFilterProvider.notifier).setFilter(newSelection.first);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: lessonsAsyncValue.when(
              data: (lessons) => _buildBody(context, lessons, windowSizeClass),
              error: (error, stack) => Center(child: Text('Błąd: $error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLessonDialog(context, ref),
        tooltip: 'Dodaj lekcję',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Lesson> lessons, WindowSizeClass windowSizeClass) {
    if (lessons.isEmpty) {
      return const Center(
        child: Text(
          'Nie znaleziono żadnych lekcji.\nNaciśnij "+", aby dodać pierwszą!',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (windowSizeClass == WindowSizeClass.compact) {
      return _buildListView(lessons);
    }
    return _buildGridLayout(lessons, windowSizeClass);
  }

  Widget _buildListView(List<Lesson> lessons) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: lessons.length,
      itemBuilder: (context, index) => _LessonCard(lesson: lessons[index]),
    );
  }

  Widget _buildGridLayout(List<Lesson> lessons, WindowSizeClass windowSizeClass) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double minTileWidth = 350.0;
        final int crossAxisCount = (constraints.maxWidth / minTileWidth).floor();
        return GridView.builder(
          padding: ResponsiveLayout.getMarginForWindowSize(windowSizeClass),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 16 / 9,
          ),
          itemCount: lessons.length,
          itemBuilder: (context, index) => _LessonCard(lesson: lessons[index]),
        );
      },
    );
  }

  Future<void> _showAddLessonDialog(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stwórz nową lekcję', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              controller: titleController,
                              decoration: const InputDecoration(labelText: 'Nazwa lekcji'),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Proszę podać nazwę';
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Opis (opcjonalnie)',
                                alignLabelWithHint: true,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Anuluj'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        child: const Text('Stwórz'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref.read(lessonActionsProvider.notifier).createLesson(
                              titleController.text.trim(),
                              descriptionController.text.trim(),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  const _LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push('/lesson/${lesson.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.title,
                style: theme.textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              if (lesson.description.isNotEmpty)
                Text(
                  lesson.description,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
