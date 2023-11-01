import 'package:flutter/material.dart';

import 'package:xpense_app/widgets/expenses_list/expenses_list.dart';
import 'package:xpense_app/widgets/new_expense.dart';
import '../models/expense_model.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Subway',
        amount: 7.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Cinema',
        amount: 11.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => const NewExpense()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xpense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
      children: [
        Text('The chart'),
        Expanded(
          child: ExpensesList(
            expenses: _registeredExpenses
          )),
      ],
    ));
  }
}
