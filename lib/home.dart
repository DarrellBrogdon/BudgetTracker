import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<APIData> jsonData;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    jsonData = fetchData();
  }

  Future<APIData> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/1.0/'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return APIData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load the categories');
    }
  }

  FutureBuilder<APIData> _budgetList() {
    return FutureBuilder<APIData>(
      future: jsonData,
      builder: (BuildContext context, AsyncSnapshot<APIData> snapshot) {
        if (snapshot.hasData) {
          return Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children:
                buildRows(snapshot.data!.categories, snapshot.data!.budget),
          );
        } else if (snapshot.hasError) {
          return Text('ERROR: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  List<TableRow> buildRows(List<Category> categories, List<Budget> budget) {
    List<TableRow> tableRows = [];

    for (var category in categories) {
      tableRows.add(
        TableRow(children: [
          TableCell(child: Text(category.category)),
          TableCell(
              child: Text(formatCurrency.format(budget
                  .firstWhere((element) => element.category == category.key)
                  .amount))),
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
