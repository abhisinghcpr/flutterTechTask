import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/visitor_analytics_model.dart';

class VisitorAnalyticsCard extends StatelessWidget {
  const VisitorAnalyticsCard({
    super.key,
    required this.analytics,
  });

  final VisitorAnalyticsModel analytics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.purpleDark],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F6450A8),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            analytics.title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            analytics.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            analytics.totalViews,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.white, size: 16),
              const SizedBox(width: 5),
              Text(
                analytics.growthText,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const SizedBox(
            height: 48,
            width: double.infinity,
            child: CustomPaint(painter: _AnalyticsPainter()),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsPainter extends CustomPainter {
  const _AnalyticsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, size.height * .85)
      ..cubicTo(
        size.width * .12,
        0,
        size.width * .17,
        0,
        size.width * .25,
        size.height * .7,
      )
      ..cubicTo(
        size.width * .36,
        size.height * 1.1,
        size.width * .4,
        0,
        size.width * .52,
        size.height * .45,
      )
      ..cubicTo(
        size.width * .63,
        size.height * 1.1,
        size.width * .7,
        0,
        size.width * .8,
        size.height * .4,
      )
      ..cubicTo(
        size.width * .88,
        size.height * .8,
        size.width * .93,
        size.height * .1,
        size.width,
        size.height * .3,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
