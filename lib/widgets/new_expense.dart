import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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
          TextField(
            controller: _amountController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Enter amount:')
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)
                ),
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                }, 
                child: Text('Save expense')
              ),
              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  
                },
                child: Text('Cancel')
              )
            ],
          )
        ],
      )
    );
  }
}