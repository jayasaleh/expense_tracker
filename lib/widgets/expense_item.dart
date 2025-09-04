import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}', //sama seperti 'hallo ${name} \$ untuk menampilkan string $ kedua untuk injeksi variable ke string'
                ), //19.9922 to 19.99
                const Spacer(), //push the next widget to the end of the row
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8), //jarak antara icon dan text
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
