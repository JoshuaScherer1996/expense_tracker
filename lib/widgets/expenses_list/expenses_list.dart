// Importing necessary local models and widgets, and the Flutter material package.
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// A stateless widget for displaying a list of expenses.
class ExpensesList extends StatelessWidget {
  // Constructor with required expenses and onRemoveExpense parameters.
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  // The list of expenses to be displayed.
  final List<Expense> expenses;
  // A callback function to handle the removal of an expense.
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // Using a ListView.builder for efficient rendering of a dynamic list of expenses.
    return ListView.builder(
      itemCount: expenses.length, // Setting the number of items in the list.
      itemBuilder: (ctx, index) => Dismissible(
        // Wrapping each item in a Dismissible widget for swipe-to-remove functionality.
        key: ValueKey(
          expenses[
              index], // Unique key for each list item based on the expense object.
        ),
        // Background color and margin when an item is swiped.
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          // Callback function called when an item is dismissed.
          onRemoveExpense(expenses[index]);
        },
        // The actual list item widget.
        child: ExpenseItem(
          // Passing the expense data to the ExpenseItem widget.
          expense: expenses[index],
        ),
      ),
    );
  }
}
