// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maneymanagment/db/category_/category_db.dart';
import 'package:maneymanagment/models/category/category_model.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Categorydb().expensecategorylist,
        builder:
            (BuildContext context, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                      onPressed: () {
                        Categorydb.instance.deleteCategory(category.id);
                      },
                      icon: Icon(Icons.delete)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}
