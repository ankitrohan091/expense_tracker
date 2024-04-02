import 'package:expense_tracker/sql/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 121, 107),
  brightness: Brightness.dark,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlHelper.openingDatabase();
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
                  fontWeight: FontWeight.bold),
            ),
            cardTheme: const CardTheme().copyWith(
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
    ),
  );
}
