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
      color: Theme.of(context).colorScheme.secondaryContainer,
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
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 21,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee_sharp,
                  color: Theme.of(context).colorScheme.surfaceTint,
                ),
                Text(
                  expenseItem.amount.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expenseItem.category],
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      dateFormatter.format(expenseItem.date),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
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
