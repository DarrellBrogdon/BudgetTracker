class Ledgers {
  final Ledger entry;

  Ledgers({required this.entry});
}

class Ledger {
  final String description;
  final String category;
  final int day;
  final double? expense;
  final String bank;
  final int month;
  final String? creditor;
  final int year;
  final String? debtor;
  final double? income;

  const Ledger({
    required this.description,
    required this.category,
    required this.day,
    this.expense,
    required this.bank,
    required this.month,
    this.creditor,
    required this.year,
    this.debtor,
    this.income,
  });
}
