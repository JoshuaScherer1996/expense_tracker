import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  // After the expense list there is a initializer list for values used with ':'
  Expense({
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
