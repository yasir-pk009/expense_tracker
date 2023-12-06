import 'package:flutter/material.dart';
import 'package:maneymanagment/db/category_/category_db.dart';
import 'package:maneymanagment/db/transaction/transaction_model.dart';
import 'package:maneymanagment/db/transaction_db/transactionDB.dart';
import 'package:maneymanagment/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = "add-transaction";

  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  final _purposeEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime? selectedTime;
  CategoryType? selectedCategoryType;
  String? selectedCategoryID;
  CategoryModel? selectedCategoryModel;

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 204, 235),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _purposeEditingController,
                  decoration: InputDecoration(
                    hintText: "Purpose",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _amountEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Amount",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate == null) {
                      return;
                    } else {
                      setState(() {
                        selectedTime = selectedDate;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today, color: Colors.black),
                  label: Text(
                    selectedTime == null
                        ? "Select time "
                        : selectedTime.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Transaction Type',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.income,
                          groupValue: selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategoryType = CategoryType.income;
                              selectedCategoryID = null;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text(
                          "Income",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.expense,
                          groupValue: selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategoryType = CategoryType.expense;
                              selectedCategoryID = null;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text(
                          "Expense",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButton(
                  value: selectedCategoryID,
                  hint: const Text("Select Category"),
                  items: (selectedCategoryType == CategoryType.income
                          ? Categorydb().incomecategorylist
                          : Categorydb.instance.expensecategorylist)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      onTap: () {
                        selectedCategoryModel = e;
                      },
                      value: e.id,
                      child: Text(
                        e.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      selectedCategoryID = selectedValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purpose = _purposeEditingController.text;
    final amount = _amountEditingController.text;

    if (purpose.isEmpty || amount.isEmpty || selectedTime == null) {
      return;
    }

    final parsedAmount = double.tryParse(amount);

    if (parsedAmount == null || selectedCategoryModel == null) {
      return;
    }

    final transactionModelObject = TransactionModel(
      purpose: purpose,
      amount: parsedAmount,
      date: selectedTime!,
      type: selectedCategoryType!,
      category: selectedCategoryModel!,
    );

    await TransactionFuction.instance.addTransaction(transactionModelObject);
    Navigator.of(context).pop();
    TransactionFuction.instance.refreshUI();
  }
}
