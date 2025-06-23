import 'package:flutter/material.dart';
import '../../../../core/widgets/responsive_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final windowSizeClass = ResponsiveLayout.getWindowSizeClass(context);
    //final isUserLoggedIn = FirebaseAuth.instance.currentUser != null;

    return AdaptiveScaffold(
      title: null,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        icon: const Icon(Icons.add),
        label: const Text('Nowa notatka'),
      ),
      body: Center(
        child: Text('Notatki'),
      )

    );
  }

  // Widget _buildBody(
  //     BuildContext context,
  //     WindowSizeClass windowSizeClass,
  //     ) {
  //   return notesState.when(
  //     loading: () => const Center(child: CircularProgressIndicator()),
  //     error: (error, stackTrace) => Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text('Błąd: $error'),
  //           ElevatedButton(
  //             onPressed: () => ref.read(notesProvider.notifier).loadNotes(),
  //             child: const Text('Spróbuj ponownie'),
  //           ),
  //         ],
  //       ),
  //     ),
  //     data: (notes) {
  //       if (notes.isEmpty) {
  //         return const Center(child: Text('Brak notatek.'));
  //       }
  //       return Padding(
  //         padding: ResponsiveLayout.getMarginForWindowSize(windowSizeClass),
  //         child: LayoutBuilder(
  //           builder: (context, constraints) => _buildGridLayout(notes, windowSizeClass),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildGridLayout(List<Note> notes, WindowSizeClass windowSizeClass) {
  //   int columns =
  //   windowSizeClass == WindowSizeClass.compact
  //       ? 1
  //       : windowSizeClass == WindowSizeClass.medium
  //       ? 2
  //       : windowSizeClass == WindowSizeClass.large
  //       ? 3
  //       : 4;
  //
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: columns,
  //       crossAxisSpacing: 16,
  //       mainAxisSpacing: 16,
  //       childAspectRatio: 1.5,
  //     ),
  //     itemCount: notes.length,
  //     itemBuilder: (context, index) => _buildGridItem(context, notes[index]),
  //   );
  // }
  //
  // Widget _buildGridItem(BuildContext context, Note note) {
  //   return NoteCard(
  //     title: note.title,
  //     content: note.content,
  //     modified: note.modifiedAt,
  //     destination: NotePage(note: note),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => NotePage(note: note)),
  //       ).then((_) {
  //         // Odśwież notatki po powrocie z ekranu edycji
  //         ref.read(notesProvider.notifier).loadNotes();
  //       });
  //     },
  //   );
  // }
}