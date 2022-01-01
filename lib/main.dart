import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      home: const Home(title: 'BudgetTracker'),
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
  late Future<Map<String, dynamic>> jsonData;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    jsonData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/1.0/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the categories');
    }
  }

  FutureBuilder<Map<String, dynamic>> _budgetList() {
    return FutureBuilder<Map<String, dynamic>>(
      future: jsonData,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          var categories = snapshot.data!.entries.elementAt(0);
          var budget = snapshot.data!.entries.elementAt(1);
          // var ledger = snapshot.data!.entries.elementAt(2);
          return Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: buildRows(categories.value, budget.value),
          );
        } else if (snapshot.hasError) {
          return Text('ERROR: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  List<TableRow> buildRows(entries, currentBudget) {
    List<TableRow> tableRows = [];

    entries.forEach((categoryKey, category) {
      var budgetValue = 0.0;
      currentBudget.forEach((k, v) {
        if (k == categoryKey) {
          budgetValue = double.parse(v);
        }
      });

      tableRows.add(
        TableRow(children: [
          TableCell(child: Text(category)),
          TableCell(child: Text(formatCurrency.format(budgetValue))),
        ]),
      );
    });

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
