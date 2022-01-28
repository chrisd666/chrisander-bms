import 'package:bms/models/product_model.dart';
import 'package:bms/widgets/inventory_dialog_form.dart';
import 'package:bms/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final Stream<QuerySnapshot> _productsStream = Product.productsRef.snapshots();

  Future<void> showDialogForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const InventoryDialogForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: Layout(
        heading: "Inventory",
        actions: [
          ElevatedButton(
              child: const Text("ADD PRODUCT"),
              onPressed: () async {
                await showDialogForm(context);
              })
        ],
        child: Column(
          children: [
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _productsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong!");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading...");
                    }

                    return DataTable(
                      headingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Item",
                        )),
                        DataColumn(label: Text("Price"), numeric: true),
                        DataColumn(label: Text("Quantity"), numeric: true),
                      ],
                      rows: snapshot.data!.docs
                          .map((DocumentSnapshot product) => DataRow(cells: [
                                DataCell(Text(product['name'])),
                                DataCell(Text(product['price'].toString())),
                                DataCell(Text(product['quantity'].toString())),
                              ]))
                          .toList(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
