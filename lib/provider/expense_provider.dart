import 'package:expense_tracker/models/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/sql/sql_helper.dart';

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]) {
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    state = await SqlHelper.queringExpenses();
  }

  Future<void> removeExpense(Expense expense) async {
    state = state.where((element) => element.id != expense.id).toList();
    await SqlHelper.openingDatabase();
    await SqlHelper.removeExpense(expense: expense);
  }

  Future<void> addExpense(Expense expense) async {
    state = [...state, expense];
    await SqlHelper.openingDatabase();
    await SqlHelper.insetingNewExpense(expense: expense);
  }
}

final expenseListProvider =
    StateNotifierProvider<ExpensesNotifier, List<Expense>>(
        (ref) => ExpensesNotifier());
