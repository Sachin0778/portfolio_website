import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Slow-moving gradient orbs for a modern “mesh” backdrop.
class PortfolioMeshBackground extends StatefulWidget {
  const PortfolioMeshBackground({super.key});

  @override
  State<PortfolioMeshBackground> createState() => _PortfolioMeshBackgroundState();
}

class _PortfolioMeshBackgroundState extends State<PortfolioMeshBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppConstants.backgroundColor,
                    Color(0xFF0A0F1C),
                    AppConstants.surfaceColor,
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPainter(opacity: 0.04),
              ),
            ),
            ..._orb(size, t, 0, AppConstants.glowPrimary, 0.42, 0.12, 380),
            ..._orb(size, t, 1, AppConstants.glowSecondary, 0.72, 0.55, 320),
            ..._orb(size, t, 2, AppConstants.glowAccent, 0.18, 0.62, 260),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppConstants.backgroundColor.withOpacity(0.15),
                      Colors.transparent,
                      AppConstants.backgroundColor.withOpacity(0.92),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _orb(
    Size size,
    double t,
    int index,
    Color color,
    double bx,
    double by,
    double diameter,
  ) {
    final phase = t * math.pi * 2 + index * 1.7;
    final dx = math.sin(phase) * 36;
    final dy = math.cos(phase * 0.85) * 28;
    return [
      Positioned(
        left: size.width * bx + dx - diameter / 2,
        top: size.height * by + dy - diameter / 2,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.38),
                  color.withOpacity(0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 1;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
