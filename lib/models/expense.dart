import 'package:flutter/material.dart';

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.food_bank_sharp,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie_creation,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.id,
  });
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.category(
      {required List<Expense> allExpenses, required this.category})
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();
  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
