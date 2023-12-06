// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:maneymanagment/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const DATABASE_NAME = "data_base";

abstract class CategoryDbFuction {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class Categorydb implements CategoryDbFuction {
  Categorydb.internal();
  static Categorydb instance = Categorydb.internal();
  factory Categorydb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomecategorylist = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensecategorylist = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(DATABASE_NAME);
    categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(DATABASE_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allcategories = await getCategories();
    incomecategorylist.value.clear();
    expensecategorylist.value.clear();
    await Future.forEach(allcategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomecategorylist.value.add(category);
      } else {
        expensecategorylist.value.add(category);
      }
    });
    // ignore: invalid_use_of_protected_member
    incomecategorylist.notifyListeners();
    // ignore: invalid_use_of_protected_member
    expensecategorylist.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(DATABASE_NAME);
    await categoryDB.delete(categoryID);
    refreshUI();
  }
}
