import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});
  @override
  ConsumerState<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime enteredDate = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  Category? selectedCategory;

  void submitNewExpense() async {
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0;
    if (titleController.text.trim().isEmpty ||
        !amountIsValid ||
        selectedCategory == null) {
      if (foundation.kIsWeb) {
        // if(foundation.defaultTargetPlatform==TargetPlatform.iOS)
        showCupertinoDialog(
            context: context,
            builder: (ctx) {
              return CupertinoAlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid title, amount, date and category is entered.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid title, amount, date and category is entered.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              );
            });
      }
    } else {
      Navigator.pop(context);
      await ref.read(expenseListProvider.notifier).addExpense(Expense(
          id: const Uuid().v4(),
          title: titleController.text,
          amount: enteredAmount,
          category: selectedCategory!,
          date: enteredDate));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  List<Widget> largeWidth() {
    return [
      Row(
        children: [
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500),
              controller: titleController,
              maxLength: 50,
              decoration: InputDecoration(
                  label: const Text('Title'),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500),
              controller: amountController,
              maxLength: 15,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: const Text('Enter Amount'),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground),
                  prefixIcon: const Icon(Icons.currency_rupee_sharp)),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text('Category : ',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            width: 3,
          ),
          DropdownButton(
              dropdownColor: Theme.of(context).colorScheme.onTertiary,
              value: selectedCategory,
              items: Category.values
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w500),
                      )))
                  .toList(),
              onChanged: (value) => setState(() {
                    selectedCategory = value;
                  })),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  icon: const Icon(
                    Icons.calendar_month_sharp,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground),
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(2100, 12, 31));
                    setState(() {
                      enteredDate = date!;
                    });
                  }),
              Text(
                formatter.format(enteredDate),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ]),
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      submitNewExpense();
                    },
                    child: const Text('Save Expenses')),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ],
            ),
          ),
        ],
      )
    ];
  }

  List<Widget> smallWidth() {
    return [
      TextField(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500),
        controller: titleController,
        maxLength: 50,
        decoration: InputDecoration(
            label: const Text('Title'),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground)),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500),
              controller: amountController,
              maxLength: 15,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: const Text('Enter Amount'),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground),
                  prefixIcon: const Icon(Icons.currency_rupee_sharp)),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  icon: const Icon(
                    Icons.calendar_month_sharp,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground),
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(2100, 12, 31));
                    setState(() {
                      enteredDate = date!;
                    });
                  }),
              Text(
                formatter.format(enteredDate),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ]),
          ),
        ],
      ),
      Row(children: [
        Text('Category : ',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(
          width: 3,
        ),
        DropdownButton(
            dropdownColor: Theme.of(context).colorScheme.onTertiary,
            value: selectedCategory,
            items: Category.values
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500),
                    )))
                .toList(),
            onChanged: (value) => setState(() {
                  selectedCategory = value;
                })),
      ]),
      const SizedBox(
        height: 4,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: submitNewExpense,
                child: const Text('Save Expenses')),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: width > 600 ? largeWidth() : smallWidth(),
          ),
        ),
      );
    });
  }
}
