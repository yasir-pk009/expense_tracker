import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maneymanagment/db/transaction/transaction_model.dart';
import 'package:maneymanagment/models/category/category_model.dart';
import 'package:maneymanagment/screens/add_transaction/screen_add_trasactio.dart';
import "package:maneymanagment/screens/home/screenHome.dart";
//import 'package:maneymanagment/screens/category/screen_category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName: (context) => const ScreenAddTransaction(),
      },
    );
  }
}
