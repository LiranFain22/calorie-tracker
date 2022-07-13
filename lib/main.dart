import 'package:flutter/material.dart';

import './models/calories.dart';
import '../widgets/calories_list.dart';
import '../widgets/new_item.dart';
import '../widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Calories> _userCalories = [];

  List<Calories> get _recentCalories {
    return _userCalories.where(
      (input) {
        return input.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _deleteItem(String id) {
    setState(() {
      _userCalories.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  void _addNewItem(String itemTitle, double itemAmount, DateTime chosenDate) {
    final newItem = Calories(
      id: DateTime.now().toString(),
      title: itemTitle,
      amount: itemAmount,
      date: chosenDate,
    );

    setState(() {
      _userCalories.add(newItem);
    });
  }

  void _startAddNewItem(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {}, // Tap on the underlying model sheet
          child: NewItem(_addNewItem),
          behavior: HitTestBehavior
              .opaque, // with this we catch the tap event and avoid that it's handle by anyone else
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calories Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentCalories),
            CaloriesList(_userCalories, _deleteItem),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewItem(context),
      ),
    );
  }
}
