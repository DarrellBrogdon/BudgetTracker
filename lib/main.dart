import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'budget.dart';
import 'categories.dart';

void main() {
  runApp(const Budgetrack());
}

class Budgetrack extends StatelessWidget {
  const Budgetrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgetrack',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(title: 'Budgetrack'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formatCurrency = NumberFormat.simpleCurrency();

  var categories = Categories().fetchCategories();

  FutureBuilder<Map<String, dynamic>> _budgetList() {
    return FutureBuilder<Map<String, dynamic>>(
      future: categories,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          return Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: buildRows(snapshot.data!.entries),
          );
        } else if (snapshot.hasError) {
          return Text('ERROR: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  List<TableRow> buildRows(entries) {
    List<TableRow> tableRows = [];

    for (var category in entries) {
      tableRows.add(
        TableRow(children: [
          TableCell(child: Text(category.value)),
          TableCell(
            child: Text(
              formatCurrency.format(Budgets().getValue(category.key)),
            ),
          ),
        ]),
      );
    }

    return tableRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _budgetList(),
    );
  }
}
