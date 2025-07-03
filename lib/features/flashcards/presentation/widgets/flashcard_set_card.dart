import 'package:flutter/material.dart';
import '../../domain/entities/flashcard_set.dart';

class FlashcardSetCard extends StatelessWidget {
  final FlashcardSet flashcardSet;
  final VoidCallback onTap;
  final VoidCallback? onManage;
  final bool isCreator;
  final Function(String)? onDelete;

  const FlashcardSetCard({
    super.key,
    required this.flashcardSet,
    required this.onTap,
    this.onManage,
    required this.isCreator,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.quiz,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          flashcardSet.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (flashcardSet.description.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              Text(
                flashcardSet.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 4),
            Text(
              '${flashcardSet.flashcardCount} fiszek',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: isCreator
            ? PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'manage':
                onManage?.call();
                break;
              case 'study':
                onTap();
                break;
              case 'delete':
                onDelete?.call(flashcardSet.id);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'study',
              child: ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text('Rozpocznij naukę'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'manage',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Zarządzaj fiszkami'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.red),
                title: Text('Usuń zestaw', style: TextStyle(color: Colors.red)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        )
            : const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}