// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maneymanagment/db/category_/category_db.dart';
import 'package:maneymanagment/db/transaction/transaction_model.dart';
import 'package:maneymanagment/db/transaction_db/transactionDB.dart';
import 'package:maneymanagment/models/category/category_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionFuction.instance.refreshUI();
    Categorydb.instance.refreshUI();

    return MaterialApp(debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          
          title: Text('Transaction Screen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable: TransactionFuction.instance.transactionNotifier,
          builder:
              (BuildContext context, List<TransactionModel> newlist, Widget? _) {
            return ListView.builder(
              itemCount: newlist.length,
              itemBuilder: (context, index) {
                final value = newlist[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          TransactionFuction.instance
                              .DeleteTransaction(value.id!);
                        },
                        icon: Icons.delete,
                        label: "Delete",
                      ),
                    ],
                  
                  ),
                  key: Key(value.id!),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        child: Text(
                          "${value.date.day}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      title: Text(
                        'RS ${value.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "Category ${value.category.name}",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        // Add your onTap logic here
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String parsedDate(DateTime date) {
    return "${date.day}\n${date.month}";
  }
}
