import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //leisure expense(category)

  String get formattedDate {
    return formatter.format(date);
  }
}
