import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
        ),
        title: const Column(
          children: [
            Text(
              'Sales Analytics Dashboard',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Track your business performance and sales trends',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards Row
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard(
                  'Today\'s Sales',
                  '₱1,092.00',
                  Icons.access_time,
                ),
                _buildStatCard(
                  'Weekly Sales',
                  '₱1,092.00',
                  Icons.calendar_today,
                ),
                _buildStatCard(
                  'Monthly Sales',
                  '₱1,092.00',
                  Icons.calendar_month,
                ),
                _buildStatCard(
                  'Yearly Sales',
                  '₱1,092.00',
                  Icons.bar_chart,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Charts
            _buildChartSection('Daily Sales Trend'),
            const SizedBox(height: 16),
            _buildChartSection('Weekly Sales Trend'),
            const SizedBox(height: 16),
            _buildChartSection('Monthly Sales Trend'),
            const SizedBox(height: 16),
            _buildChartSection('Yearly Sales Trend'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.brown),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(String title) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.white,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: ChartPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    // Draw horizontal lines (y-axis grid)
    for (var i = 0; i <= 6; i++) {
      final y = (size.height / 6) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw y-axis labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );

    for (var i = 0; i <= 6; i++) {
      final value = (1200 - (i * 200)).toString();
      textPainter.text = TextSpan(
        text: '₱$value',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(0, (size.height / 6) * i - textPainter.height / 2),
      );
    }

    // Draw x-axis label (date)
    textPainter.text = TextSpan(
      text: '2024-12-11',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width / 2 - textPainter.width / 2,
          size.height - textPainter.height),
    );

    // Draw the data point
    final pointPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(
      PointMode.points,
      [Offset(size.width / 2, size.height - 20)],
      pointPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
