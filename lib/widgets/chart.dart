import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/calories.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Calories> recentCalories;

  Chart(this.recentCalories);

  List<Map<String, Object>> get groupedCaloriesValues {
    return List.generate(7, (index) {
      // (7 days)
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentCalories.length; i++) {
        if (recentCalories[i].date.day == weekDay.day &&
            recentCalories[i].date.month == weekDay.month &&
            recentCalories[i].date.year == weekDay.year) {
          totalSum += recentCalories[i].amount;
        }
      }

      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 1), // To see one character. e.g: 'M' for Monday
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalCalories {
    return groupedCaloriesValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedCaloriesValues.map(
            (data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  (data['day'] as String),
                  (data['amount'] as double),
                  totalCalories == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalCalories,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
