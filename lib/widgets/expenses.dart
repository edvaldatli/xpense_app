import 'package:flutter/material.dart';

import 'package:xpense_app/widgets/expenses_list/expenses_list.dart';
import 'package:xpense_app/widgets/new_expense.dart';
import 'package:xpense_app/models/expense_model.dart';
import 'chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

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
    Expense(
        title: 'Business trip',
        amount: 149.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(title: 'Flight to Dubai', amount: 459.45, date: DateTime.now(), category: Category.travel),
    Expense(title: 'American Style', amount: 29, date: DateTime.now(), category: Category.food)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text('No expenses found. Start adding some'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: width < 600 ? Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent),
          ],
        ) : Row(
          children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
            Expanded(child: mainContent),
          ],
        )
        );
  }
}
