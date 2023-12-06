// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maneymanagment/db/category_/category_db.dart';
import 'package:maneymanagment/models/category/category_model.dart';

ValueNotifier<CategoryType> selectCategory = ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Add Categories",style: TextStyle(fontWeight: FontWeight.w500),),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type category name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  RadioButton(title: "Income", type: CategoryType.income),
                  RadioButton(title: "Expense", type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 83, 159, 221),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () {
                  final name = nameEditingController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final _type = selectCategory.value;
                  final _category = CategoryModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: name,
                      type: _type);

                  Categorydb().insertCategory(_category);
                  Navigator.of(context).pop();
                },
                child: Text("Add"),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType? type;
  const RadioButton({super.key, required this.title, required this.type});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectCategory,
            builder: (BuildContext context, CategoryType newCategoryType,
                Widget? _) {
              return Radio(
                value: type,
                groupValue: selectCategory.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectCategory.value = value;
                  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                  selectCategory.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
