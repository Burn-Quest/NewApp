import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCharacter extends StatefulWidget {
  const AnimatedCharacter({super.key});

  @override
  State<AnimatedCharacter> createState() => _AnimatedCharacterState();
}

class _AnimatedCharacterState extends State<AnimatedCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomPaint(
                size: const Size(150, 150),
                painter: CharacterPainter(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw face
    final facePaint =
        Paint()
          ..color = Colors.amber.shade200
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), size.width / 2.5, facePaint);

    // Draw eyes
    final eyePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 20, centerY - 10), 8, eyePaint);
    canvas.drawCircle(Offset(centerX + 20, centerY - 10), 8, eyePaint);

    // Draw smile
    final smilePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 15),
        width: 60,
        height: 40,
      ),
      0,
      math.pi,
      false,
      smilePaint,
    );

    // Draw safety helmet
    final helmetPaint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY - 20),
        width: 100,
        height: 80,
      ),
      math.pi,
      math.pi,
      true,
      helmetPaint,
    );

    // Draw helmet strap
    final strapPaint =
        Paint()
          ..color = Colors.red.shade700
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    canvas.drawLine(
      Offset(centerX - 40, centerY - 20),
      Offset(centerX - 30, centerY + 30),
      strapPaint,
    );
    canvas.drawLine(
      Offset(centerX + 40, centerY - 20),
      Offset(centerX + 30, centerY + 30),
      strapPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
