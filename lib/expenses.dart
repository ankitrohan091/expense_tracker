import 'package:expense_tracker/add_expense.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expenses extends ConsumerStatefulWidget {
  const Expenses({super.key});
  @override
  ConsumerState<Expenses> createState() {
    return _ExpensesState();
  }
}

// final List<Expense> list = [
//   Expense(
//       title: "Flutter Course",
//       amount: 1999.00,
//       date: DateTime(2024, 9, 02, 22, 56),
//       category: Category.work),
//   Expense(
//       title: "Patiala Company Visited",
//       amount: 500,
//       date: DateTime(2024, 03, 03),
//       category: Category.travel),
//   Expense(
//       title: "Crakk Movie",
//       amount: 500,
//       date: DateTime.now(),
//       category: Category.leisure),
//   Expense(
//     title: "Resturant on Saturday Night",
//     amount: 150,
//     date: DateTime(2024, 03, 09, 20, 00),
//     category: Category.food,
//   )
// ];

class _ExpensesState extends ConsumerState<Expenses> {
  @override
  Widget build(context) {
    final list = ref.watch(expenseListProvider);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: width < 600
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chart(
                      height: 180,
                      expenses: list,
                    ),
                    Expanded(
                      child: list.isNotEmpty
                          ? ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  background: Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withOpacity(0.65),
                                  ),
                                  key: ValueKey(list[index]),
                                  onDismissed: (direction) {
                                    final obj = list[index];
                                    list.remove(obj);
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Expense Deleted!'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            list.insert(index, obj);
                                          },
                                        ),
                                      ),
                                    );
                                    direction = DismissDirection.horizontal;
                                  },
                                  child: Item(list[index]),
                                );
                              })
                          : Center(
                              child:
                                  Text('No Expenses found. Start Adding Some!',style: Theme.of(context).textTheme.bodyLarge,),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 32,
                          hoverColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          highlightColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          onPressed: () {
                            showModalBottomSheet(
                                useSafeArea: true,
                                context: context,
                                isScrollControlled: true,
                                builder: (ctx) {
                                  return const AddExpense();
                                });
                          },
                          icon: const Icon(Icons.add_sharp),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Chart(
                      height: 250,
                      expenses: list,
                    )),
                    Expanded(
                      child: list.isNotEmpty
                          ? ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  background: Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withOpacity(0.65),
                                  ),
                                  key: ValueKey(list[index]),
                                  onDismissed: (direction) {
                                    final obj = list[index];
                                    list.remove(obj);
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Expense Deleted!'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            list.insert(index, obj);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Item(list[index]),
                                );
                              })
                          : const Center(
                              child:
                                  Text('No Expenses found. Start Adding Some!'),
                            ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              iconSize: 32,
                              hoverColor: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              highlightColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              onPressed: () {
                                showModalBottomSheet(
                                    useSafeArea: true,
                                    context: context,
                                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    isScrollControlled: true,
                                    builder: (ctx) {
                                      return const AddExpense();
                                    });
                              },
                              icon: const Icon(Icons.add_sharp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ));
  }
}
