import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'package:xpense_app/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {*/
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color.fromARGB(255, 40, 40, 40),
            useMaterial3: true,
            cardTheme: const CardTheme().copyWith(
              color: Colors.black38,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer),
            ),
            colorScheme: kDarkColorScheme.copyWith(error: Colors.red),
          ),
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 16,
                  ),
                ),
          ),
          themeMode: ThemeMode.system, // default setting
          home: const Expenses(),
        ),
      );
    //},
 //);
}
