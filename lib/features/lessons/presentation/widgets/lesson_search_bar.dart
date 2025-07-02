import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rewise_kit/core/services/injection_container.dart';
import 'package:rewise_kit/features/lessons/domain/entities/lesson.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/search_lessons_usecase.dart';

class LessonSearchBar extends ConsumerStatefulWidget {
  const LessonSearchBar({super.key});

  @override
  ConsumerState<LessonSearchBar> createState() => _LessonSearchBarState();
}

class _LessonSearchBarState extends ConsumerState<LessonSearchBar> {
  final SearchController _searchController = SearchController();
  Timer? _debounce;

  Future<List<Lesson>> _search(String query) {
    final completer = Completer<List<Lesson>>();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1500), () async {
      if (!mounted) {
        completer.complete([]);
        return;
      }
      try {
        final searchUseCase = sl<SearchLessonsUseCase>();
        final result = await searchUseCase(SearchLessonsParams(query: query));
        result.fold(
          (failure) => completer.complete([]),
          (lessons) => completer.complete(lessons),
        );
      } catch (e) {
        completer.completeError(e);
      }
    });

    return completer.future;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _searchController,
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Szukaj lekcji',
          onPressed: () => controller.openView(),
        );
      },
      suggestionsBuilder: (context, controller) async {
        final query = controller.text;
        if (query.length < 2) {
          if (query.isNotEmpty) {
            return [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Wpisz co najmniej 2 znaki...'),
                ),
              ),
            ];
          }
          return []; // Pusta lista, gdy pole jest puste
        }

        return [
          FutureBuilder<List<Lesson>>(
            future: _search(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Wystąpił błąd.'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Brak wyników.'),
                  ),
                );
              }

              final lessons = snapshot.data!;
              return Column(
                children:
                    lessons.map((lesson) {
                      return ListTile(
                        title: Text(lesson.title),
                        subtitle:
                            lesson.description.isNotEmpty
                                ? Text(
                                  lesson.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                                : null,
                        onTap: () {
                          controller.closeView(null);
                          context.push('/lesson/${lesson.id}');
                        },
                      );
                    }).toList(),
              );
            },
          ),
        ];
      },
    );
  }
}
