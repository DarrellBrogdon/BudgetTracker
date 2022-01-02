import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const BudgetTracker());
}

class BudgetTracker extends StatelessWidget {
  const BudgetTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgetrack',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(title: 'BudgetTracker'),
    );
  }
}
