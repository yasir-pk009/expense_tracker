// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maneymanagment/models/category/category_add_popup.dart';
import 'package:maneymanagment/screens/add_transaction/screen_add_trasactio.dart';
import 'package:maneymanagment/screens/home/widgets/bottam_navigation.dart';
import 'package:maneymanagment/screens/category/screen_category.dart';
import 'package:maneymanagment/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectednotifierIndex = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 119, 10, 123),
      bottomNavigationBar: const MoneymangmentBottomNavigotion(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("EXPENSE TRACKER",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectednotifierIndex.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectednotifierIndex,
        builder: (BuildContext context, int updatedIndex, _) =>
            _pages[updatedIndex],
      )),
    );
  }
}
