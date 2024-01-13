// Importing necessary local models and Flutter material package.
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// A stateless widget for displaying a single expense item.
class ExpenseItem extends StatelessWidget {
  // Constructor with required expense parameter.
  const ExpenseItem({required this.expense, super.key});

  // The expense object to display.
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Building the visual representation of an expense item.
    return Card(
      // Wrapping the content in a Card widget for a polished look.
      child: Padding(
        // Adding symmetric padding around the content.
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the title of the expense.
            Text(
              expense.title,
              // Styling the title using the current theme's large title text style.
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              // Row layout to display the amount and the date of the expense.
              children: [
                // Displaying the amount of the expense.
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                // Displaying the category icon and formatted date.
                Row(
                  children: [
                    // Icon representing the expense's category.
                    Icon(categoryItems[expense.category]),
                    const SizedBox(width: 8),
                    // Displaying the formatted date of the expense.
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
