// Importing necessary Flutter and external packages.
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Global formatter for formatting dates in 'year-month-day' format.
final formatter = DateFormat.yMd();

// Global constant for UUID generation.
const uuid = Uuid();

// Enumeration for different expense categories.
enum Category { food, travel, leisure, work }

// Mapping of expense categories to corresponding icons.
const categoryItems = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Class defining the structure of an Expense object.
class Expense {
  // Constructor for Expense class with named parameters and automatic ID generation.

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    // Initializer for values used with ':'
  }) : id = uuid.v4();

  // Unique identifier for each expense.
  final String id;
  // Title or description of the expense.
  final String title;
  // Monetary amount of the expense.
  final double amount;
  // Date of the expense.
  final DateTime date;
  // Category of the expense.
  final Category category;

  // Method to get formatted date string.
  String get formattedDate {
    return formatter.format(date);
  }
}

// Class for grouping expenses into categories.
class ExpenseBucket {
  // Constructor for ExpenseBucket with required parameters.
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // Factory constructor for creating an ExpenseBucket for a specific category.
  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  // Category of the expense bucket.
  final Category category;
  // List of expenses in the bucket.
  final List<Expense> expenses;

  // Computed property to calculate total expenses in the bucket.
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
