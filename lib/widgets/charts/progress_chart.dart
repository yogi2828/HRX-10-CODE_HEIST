// lib/widgets/charts/progress_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Make sure to add fl_chart to pubspec.yaml
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class ProgressChart extends StatelessWidget {
  final Map<DateTime, int> dailyXpData; // Key: Date, Value: XP earned on that date

  const ProgressChart({super.key, required this.dailyXpData});

  @override
  Widget build(BuildContext context) {
    if (dailyXpData.isEmpty) {
      return Center(
        child: Text(
          'No XP data to display yet.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
        ),
      );
    }

    // Sort data by date
    final sortedDates = dailyXpData.keys.toList()..sort();

    // Prepare data for LineChart
    final List<FlSpot> spots = [];
    double maxX = 0;
    double maxY = 0;

    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final xp = dailyXpData[date] ?? 0;
      spots.add(FlSpot(i.toDouble(), xp.toDouble()));
      if (i > maxX) maxX = i.toDouble();
      if (xp > maxY) maxY = xp.toDouble();
    }

    // Add padding to maxY for better visualization
    maxY = (maxY * 1.2).ceilToDouble();
    if (maxY < 100) maxY = 100; // Ensure a minimum scale for visibility

    return AspectRatio(
      aspectRatio: 1.70,
      child: Card(
        color: AppColors.cardColor.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: AppColors.borderColor,
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: AppColors.borderColor,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < sortedDates.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: AppConstants.spacing / 2),
                          child: Text(
                            '${sortedDates[index].day}/${sortedDates[index].month}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textColorSecondary),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textColorSecondary),
                        textAlign: TextAlign.left,
                      );
                    },
                    interval: maxY / 4 > 10 ? (maxY / 4).ceilToDouble() : 10, // Adjust interval dynamically
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(color: AppColors.borderColor, width: 2),
                  left: BorderSide(color: AppColors.borderColor, width: 2),
                  right: BorderSide(color: AppColors.transparent),
                  top: BorderSide(color: AppColors.transparent),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.xpColor.withOpacity(0.8),
                      AppColors.accentColor.withOpacity(0.8),
                    ],
                  ),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.xpColor.withOpacity(0.3),
                        AppColors.accentColor.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              minX: 0,
              maxX: maxX,
              minY: 0,
              maxY: maxY,
            ),
          ),
        ),
      ),
    );
  }
}
