class APIData {
  final Map<String, dynamic> parsedJson;
  List<Category> categories;
  List<Budget> budget;
  List<LedgerEntry> ledger;

  APIData(
      {required this.parsedJson,
      required this.categories,
      required this.budget,
      required this.ledger});

  factory APIData.fromJson(Map<String, dynamic> parsedJson) {
    final categoriesMap = parsedJson['categories'] as Map;
    final List<Category> categories = categoriesMap.entries
        .map((e) => Category(key: e.key, category: e.value))
        .toList();

    final budgetMap = parsedJson['budget'] as Map;
    final List<Budget> budget = budgetMap.entries
        .map((e) => Budget(category: e.key, amount: double.parse(e.value)))
        .toList();

    final ledgerList = parsedJson['ledger'] as List;
    final List<LedgerEntry> ledger = ledgerList
        .map((e) => LedgerEntry(
            category: e['category'],
            day: int.parse(e['day']),
            month: int.parse(e['month']),
            year: int.parse(e['year']),
            bank: e['bank'],
            description: e['description'],
            creditor: e['creditor'],
            debtor: e['debtor'],
            expense: double.parse(e['expense']),
            income: double.parse(e['income'])))
        .toList();

    return APIData(
        parsedJson: parsedJson,
        categories: categories,
        budget: budget,
        ledger: ledger);
  }
}

class Category {
  final String key;
  final String category;

  Category({required this.key, required this.category});
}

class Budget {
  final String category;
  final double amount;

  Budget({required this.category, required this.amount});
}

class LedgerEntry {
  final double? income;
  final String? creditor;
  final int year;
  final double? expense;
  final String category;
  final int month;
  final int day;
  final String? debtor;
  final String bank;
  final String description;

  LedgerEntry(
      {required this.category,
      required this.day,
      required this.month,
      required this.year,
      required this.bank,
      required this.description,
      this.income,
      this.expense,
      this.creditor,
      this.debtor});
}
