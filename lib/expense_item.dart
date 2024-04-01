import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item extends StatelessWidget {
  Item(this.expenseItem, {super.key});
  final Expense expenseItem;
  final dateFormatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(Icons.currency_rupee_sharp),
                Text(expenseItem.amount.toStringAsFixed(2)),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenseItem.category]),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      dateFormatter.format(expenseItem.date),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
