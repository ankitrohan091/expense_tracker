import 'package:expense_tracker/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses;
  const Chart({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.category(allExpenses: expenses, category: Category.food),
      ExpenseBucket.category(allExpenses: expenses, category: Category.leisure),
      ExpenseBucket.category(allExpenses: expenses, category: Category.travel),
      ExpenseBucket.category(allExpenses: expenses, category: Category.work),
    ];
  }

  double get maxExpenses {
    double max = 0;
    for (final bucket in buckets) {
      if (max < bucket.totalExpense) {
        max = bucket.totalExpense;
      }
    }
    return max;
  }

  @override
  Widget build(context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.primary.withOpacity(0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpense / maxExpenses,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: buckets
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[e.category],
                        color: isDarkMode
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                            : Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
