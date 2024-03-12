import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 230, 120, 243),
  brightness: Brightness.dark,
);
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          scaffoldBackgroundColor: kColorScheme.background,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          textTheme: const TextTheme().copyWith(
              displaySmall: TextStyle(
                  fontSize: 12,
                  color: kColorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500),
              titleLarge: TextStyle(
                  fontSize: 16,
                  color: kColorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold)),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.inversePrimary,
          ))),
          darkTheme: ThemeData().copyWith(
            colorScheme: kDarkColorScheme,
          ),
      home: const Expenses(),
    ),
  );
}
