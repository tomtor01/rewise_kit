import 'package:flutter/material.dart';
import '../../domain/entities/flashcard.dart';

class FlashcardCard extends StatefulWidget {
  final Flashcard flashcard;
  final bool isRevealed;
  final VoidCallback? onTap;

  const FlashcardCard({
    super.key,
    required this.flashcard,
    required this.isRevealed,
    this.onTap,
  });

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Inicjalizuj stan na podstawie isRevealed
    _showBack = widget.isRevealed;
    if (widget.isRevealed) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FlashcardCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Jeśli zmienił się flashcard, zresetuj animację
    if (oldWidget.flashcard != widget.flashcard) {
      _controller.reset();
      _showBack = false;
    }

    // Jeśli zmienił się stan revealed
    if (widget.isRevealed != oldWidget.isRevealed) {
      if (widget.isRevealed) {
        _controller.forward().then((_) {
          if (mounted) {
            setState(() {
              _showBack = true;
            });
          }
        });
      } else {
        setState(() {
          _showBack = false;
        });
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value * 3.14159),
            child: _animation.value <= 0.5
                ? _buildFrontCard()
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(3.14159),
              child: _showBack ? _buildBackCard() : _buildFrontCard(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    return Card(
      elevation: 8,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 24),
            Text(
              'Pytanie',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  widget.flashcard.front,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Dotknij aby zobaczyć odpowiedź',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Card(
      elevation: 8,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.withOpacity(0.1),
              Colors.green.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb,
              size: 48,
              color: Colors.green[700],
            ),
            const SizedBox(height: 24),
            Text(
              'Odpowiedź',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  widget.flashcard.back,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Czy znasz odpowiedź?',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}