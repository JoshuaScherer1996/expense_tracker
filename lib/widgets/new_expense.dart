// Importing necessary Flutter material package and local models.
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// A StatefulWidget to handle the creation of a new expense.
class NewExpense extends StatefulWidget {
  // Constructor with required onAddExpense callback parameter.
  const NewExpense({super.key, required this.onAddExpense});

  // Callback function to add an Expense.
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

// Private State class for the NewExpense StatefulWidget.
class _NewExpenseState extends State<NewExpense> {
  // Text editing controllers for title and amount input fields.
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // Variables to hold the selected date and category.
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // Function to show a date picker dialog.
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Function to submit the entered expense data.
  void _submitExpenseData() {
    // tryParse('Hello') -> null, tryParse('1.12') -> 1.12
    // Parsing the entered amount and validating the input data.
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // Showing a dialog if the input is invalid.
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input!'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    // Adding the new expense.
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    // Closing the modal after submission.
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Disposing controllers when the widget is removed from the widget tree.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current keyboard height from the MediaQuery's viewInsets.
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // Building the UI for the new expense form.
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            48,
            16,
            keyboardSpace + 16,
          ),
          child: Column(
            children: [
              // Text field for the expense title.
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  // Text field for the expense amount.
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Container for the date picker and selected date display.
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  // Dropdown for selecting the expense category.
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  // Button to submit the new expense data.
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('save expense'),
                  ),
                  // Button to cancel and close the modal.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
