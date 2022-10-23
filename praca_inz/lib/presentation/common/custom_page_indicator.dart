import 'package:flutter/material.dart';

class CustomPageIndicator extends AnimatedWidget {
  const CustomPageIndicator({
    required this.controller,
    required this.count,
    required this.activeColor,
    required this.inactiveColor,
    Key? key,
  }) : super(
          key: key,
          listenable: controller,
        );

  final PageController controller;
  final int count;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomIndicatorPainter(
        count,
        controller.page ?? controller.initialPage.toDouble(),
        activeColor,
        inactiveColor,
      ),
      child: const SizedBox(),
    );
  }
}

class _CustomIndicatorPainter extends CustomPainter {
  final int count;
  final double offset;
  final Color activeColor;
  final Color inactiveColor;

  const _CustomIndicatorPainter(
    this.count,
    this.offset,
    this.activeColor,
    this.inactiveColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final singleDotSize = size.width / ((count * 2) + 1);
    final expandedWidth = singleDotSize * 2;

    double currentXPos = 0.0;

    final int active = offset.floor();

    final yStart = (size.height - singleDotSize) / 2.0;

    for (var i = 0; i < count; i++) {
      double width = expandedWidth + singleDotSize;

      if (i == active) {
        width -= (offset - i) * expandedWidth;
      } else if (i - 1 == active) {
        width = singleDotSize + (offset - i + 1) * expandedWidth;
      } else {
        width = singleDotSize;
      }

      final color = Color.lerp(
        activeColor,
        inactiveColor,
        -0.5 * (width / singleDotSize) + 1.5,
      )!;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(currentXPos, yStart),
            Offset(currentXPos + width, yStart + singleDotSize),
          ),
          Radius.circular(singleDotSize),
        ),
        paint..color = color,
      );

      currentXPos += width + singleDotSize;
    }
  }

  @override
  bool shouldRepaint(covariant _CustomIndicatorPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
