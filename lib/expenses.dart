import 'package:expense_tracker/add_expense.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

final List<Expense> list = [
  Expense(
      title: "Flutter Course",
      amount: 1999.00,
      date: DateTime(2024, 9, 02, 22, 56),
      category: Category.work),
  Expense(
    title: "Patiala Company Visited",
    amount: 500,
    date: DateTime(2024,03,03),
    category: Category.travel
  ),
  Expense(
      title: "Crakk Movie",
      amount: 500,
      date: DateTime.now(),
      category: Category.leisure),
  Expense(
    title: "Resturant on Saturday Night",
    amount: 150,
    date: DateTime(2024, 03, 09, 20, 00),
    category: Category.food,
  )
];

class _ExpensesState extends State<Expenses> {
  void addNewExpenseInList(Expense obj) {
    setState(() {
      list.add(obj);
    });
  }

  void removeExpenseFromList(Expense obj){
    int index=list.indexOf(obj);
    setState(() {
      list.remove(obj);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(label: 'Undo',
        onPressed: (){
          setState(() {
            list.insert(index, obj);
          });
        },
        ),
      ),
    );
  }

  void addExpenses() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return AddExpense(addNewExpenseInList);
        });
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Chart(expenses: list,),
              Expanded(
                child: list.isNotEmpty?ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.65),),
                        key: ValueKey(list[index]),
                        onDismissed: (direction){
                          removeExpenseFromList(list[index]);
                          direction=DismissDirection.horizontal;
                        },
                        child: Item(list[index]),
                      );
                    }):const Center(child: Text('No Expenses found. Start Adding Some!'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 32,
                    hoverColor: Theme.of(context).colorScheme.onInverseSurface,
                    highlightColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    onPressed: addExpenses,
                    icon: const Icon(Icons.add_sharp),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
