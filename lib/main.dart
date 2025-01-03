import 'package:flutter/material.dart';
import 'package:middleware_technology/presentation/pages/create_shopping_item.dart';
import 'package:middleware_technology/presentation/pages/shopping_item_list.dart';
import 'package:middleware_technology/presentation/pages/update_shopping_item.dart';
import 'package:middleware_technology/utils/routes.dart';
import 'package:middleware_technology/utils/update_shopping_item_arguments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping REST API',
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShoppingItemListScreen(),
      routes: {
        shoppingItemListRoute: (context) => const ShoppingItemListScreen(),
        createShoppingItemRoute: (context) => const CreateShoppingItemScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case updateShoppingItemRoute:
            final args = settings.arguments as UpdateShoppingItemArguments;
            return MaterialPageRoute<String>(
              builder: (BuildContext context) => UpdateShoppingItemScreen(
                itemName: args.itemName,
              ),
              settings: settings,
            );
        }
        return null;
      },
    );
  }
}

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.cyanAccent),
    ),
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.cyanAccent.withOpacity(0.14);
          }
          return Colors.transparent;
        },
      ),
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    todayForegroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black87;
        }
        return Colors.cyanAccent;
      },
    ),
    todayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.cyanAccent;
        }
        return Colors.transparent;
      },
    ),
    dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.cyanAccent;
        }
        return Colors.transparent;
      },
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.cyanAccent;
        },
      ),
    ),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.grey;
        },
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.cyanAccent),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.cyanAccent),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.cyanAccent,
    selectionHandleColor: Colors.cyanAccent,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.cyanAccent,
    foregroundColor: Colors.black87,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.cyanAccent,
    indicatorColor: Colors.cyanAccent,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.cyanAccent,
  ),
);
