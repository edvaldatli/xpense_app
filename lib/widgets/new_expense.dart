import 'package:flutter/material.dart';
import 'expenses.dart';
import '../models/expense_model.dart' as categories;

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(categories.Expense newExpense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  categories.Category _selectedCategory = categories.Category.leisure;

  void _presentDayPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Invalid input'),
        content: Text('Please make sure a valid title, amount, date and category was entered.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, 
          child: Text('Okay'))
        ],
      ));
      return;
    }
    widget.onAddExpense(categories.Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 80, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text, // not necessary, but keeping here. This is the default value for keyboardType.
            decoration: const InputDecoration(
              label: Text('Title of expense:')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Enter amount:')
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDayPicker,
                      icon: Icon(Icons.calendar_month)
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: categories.Category.values.map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name.toUpperCase())
                  )
                ).toList(), 
                onChanged: (value) {
                  if(value == null){
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData, 
                child: Text('Save expense')
              ),
            ],
          )
        ],
      )
    );
  }
}