import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.addNewExpense,{super.key});
  final void Function(Expense) addNewExpense;
  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime enteredDate = DateTime.now();
  final formatter = DateFormat('dd/MM/yyyy');
  Category? selectedCategory;

  void submitNewExpense() {
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0;
    if (titleController.text.trim().isEmpty ||
        !amountIsValid ||
        selectedCategory == null) {
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
    } else{
      Navigator.pop(context);
      widget.addNewExpense(Expense(
        title: titleController.text, 
        amount: enteredAmount, 
        date: enteredDate, 
        category: selectedCategory!),
        );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Enter Amount'),
                      prefixIcon: Icon(Icons.currency_rupee_sharp)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                      icon: const Icon(Icons.calendar_month_sharp),
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
                  Text(formatter.format(enteredDate)),
                ]),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Category : '),
              const SizedBox(
                width: 3,
              ),
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(e.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) => setState(() {
                        selectedCategory = value;
                      })),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: submitNewExpense,
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
        ],
      ),
    );
  }
}
