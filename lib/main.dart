import 'package:flutter/material.dart';

import 'package:xpense_app/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: Expenses(),
    ),
  );
}