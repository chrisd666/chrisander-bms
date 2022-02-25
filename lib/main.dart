import 'package:bms/screens/inventory_log_screen.dart';
import 'package:bms/screens/inventory_screen/inventory_screen.dart';
import 'package:bms/screens/sales_screen/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const productsBox = 'products';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chrisander BMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => InventoryScreen(),
        'sales': (context) => SaleScreen(),
        'inventory-logs': (context) => InventoryLogScreen()
      },
    );
  }
}
