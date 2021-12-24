class Budgets {
  final double? income;
  final double? groceries;
  final double? misc;
  final double? dining;
  final double? haircutsClothing;
  final double? gifts;
  final double? homeRepairMaintenance;
  final double? internetTechnology;
  final double? entertainment;
  final double? medical;
  final double? school;
  final double? autoFuelParkingMaintenance;
  final double? utilities;
  final double? selfEmploymentTax;
  final double? insurance;
  final double? cellPhones;
  final double? bjj;
  final double? piano;
  final double? mortgage;
  final double? carRegistration;
  final double? taxPrep;

  Budgets({
    this.income,
    this.groceries,
    this.misc,
    this.dining,
    this.haircutsClothing,
    this.gifts,
    this.homeRepairMaintenance,
    this.internetTechnology,
    this.entertainment,
    this.medical,
    this.school,
    this.autoFuelParkingMaintenance,
    this.utilities,
    this.selfEmploymentTax,
    this.insurance,
    this.cellPhones,
    this.bjj,
    this.piano,
    this.mortgage,
    this.carRegistration,
    this.taxPrep,
  });

  final List<Budget> budgets = [
    Budget(key: 'income', value: 1.2),
    Budget(key: 'groceries', value: 3.4),
    Budget(key: 'misc', value: 5.6),
    Budget(key: 'dining', value: 7.8),
    Budget(key: 'haircutsClothing', value: 9.0),
    Budget(key: 'gifts', value: 1.2),
    Budget(key: 'homeRepairMaintenance', value: 3.4),
    Budget(key: 'internetTechnology', value: 5.6),
    Budget(key: 'entertainment', value: 7.8),
    Budget(key: 'medical', value: 9.0),
    Budget(key: 'school', value: 1.2),
    Budget(key: 'autoFuelParkingMaintenance', value: 3.4),
    Budget(key: 'utilities', value: 5.6),
    Budget(key: 'selfEmploymentTax', value: 7.8),
    Budget(key: 'insurance', value: 9.0),
    Budget(key: 'cellPhones', value: 1.2),
    Budget(key: 'bjj', value: 3.4),
    Budget(key: 'piano', value: 5.6),
    Budget(key: 'mortgage', value: 7.8),
    Budget(key: 'carRegistration', value: 9.0),
    Budget(key: 'taxPrep', value: 1.2),
  ];

  double getValue(String key) {
    return budgets.firstWhere((element) => element.key == key).value;
  }
}

class Budget {
  final String key;
  final double value;

  Budget({required this.key, required this.value});
}
