// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/foundation.dart';
import 'package:maneymanagment/db/transaction/transaction_model.dart';
import 'package:hive/hive.dart';
// import 'package:maneymanagment/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:maneymanagment/models/category/category_model.dart';

const DATABASE_NAME_TRANSACTION = "add_transaction";

abstract class TransactionDBFunction {
  Future<void> addTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransactions();
  Future<void> DeleteTransaction(String id);
}

class TransactionFuction implements TransactionDBFunction {
  TransactionFuction.internal();
  static TransactionFuction instance = TransactionFuction.internal();
  factory TransactionFuction() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(DATABASE_NAME_TRANSACTION);
    await transactionDB.put(value.id, value);
  }

  Future<void> refreshUI() async {
    final _list = await getTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(_list);
    // ignore: invalid_use_of_protected_member
    transactionNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(DATABASE_NAME_TRANSACTION);

    return transactionDB.values.toList();
  }

  @override
  Future<void> DeleteTransaction(String id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(DATABASE_NAME_TRANSACTION);
    await transactionDB.delete(id);
    refreshUI();
  }
}
