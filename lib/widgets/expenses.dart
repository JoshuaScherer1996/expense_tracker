// Importing necessary Flutter widgets and local models.
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// A StatefulWidget that manages the state and UI for the Expenses.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

// Private State class for the Expenses StatefulWidget.
class _ExpensesState extends State<Expenses> {
  // A list to keep track of all registered expenses.
  final List<Expense> _registeredExpenses = [
    // Pre-populated expenses for demonstration.
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Buying Games',
      amount: 69.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // Function to open the bottom sheet for adding a new expense.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // Function to add a new expense to the list.
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Function to remove an expense from the list.
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Showing a snackbar with an undo action.
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undoing the deletion.
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Saving the width every time the build method is executed.
    final width = MediaQuery.of(context).size.width;

    // Default content when there are no expenses.
    Widget mainContent = const Center(
      child: Text('No expenss found. Start adding some!'),
    );

    // Updating the main content if there are registered expenses.
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // Building the Scaffold with an AppBar, Chart, and list of expenses.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          // Button to open the add expense overlay.
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // Rendering content dependend on the width (orientation).
      body: width < 600
          ? Column(
              children: [
                // Displaying the chart of expenses.
                Chart(expenses: _registeredExpenses),
                // The main content displaying either a message or the list of expenses.
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                // Displaying the chart of expenses.
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                // The main content displaying either a message or the list of expenses.
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
