import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/calories.dart';

class CaloriesList extends StatelessWidget {
  final List<Calories> caloriesList;
  final Function deleteItemFromList;

  CaloriesList(this.caloriesList, this.deleteItemFromList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: caloriesList.isEmpty
          ? Column(
              children: [
                Text(
                  'No Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // TODO: add image
              ],
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('cal${caloriesList[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      '${caloriesList[index].title}',
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().add_jm().format(
                        caloriesList[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () =>
                          deleteItemFromList(caloriesList[index].id),
                    ),
                  ),
                );
              }),
              itemCount: caloriesList.length,
            ),
    );
  }
}
