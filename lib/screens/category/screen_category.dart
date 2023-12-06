import 'package:flutter/material.dart';
import 'package:maneymanagment/db/category_/category_db.dart';
import 'package:maneymanagment/screens/category/expense_category.dart';
import 'package:maneymanagment/screens/category/incomeCatergory_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Categorydb().refreshUI();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 8, // Add elevation for a subtle shadow
        title: const Text(
          'Categories' ,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white, // Indicator color
          indicatorWeight: 3.0, // Indicator thickness
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          unselectedLabelColor: Colors.grey[300], // Adjust to your liking
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "INCOME",
              icon: Icon(Icons.attach_money),
            ),
            Tab(
              text: "EXPENSE",
              icon: Icon(Icons.money_off),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          IncomeCategoryList(),
          ExpenseCategory(),
        ],
      ),
    );
  }
}
