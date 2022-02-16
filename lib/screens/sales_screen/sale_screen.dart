import 'package:bms/screens/sales_screen/sale_dialog_form.dart';
import 'package:bms/widgets/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bms/models/sale.dart';

class SaleScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _salesStream = Sale.salesRef.snapshots();

  SaleScreen({Key? key}) : super(key: key);

  Future<void> _showCreateUpdateDialogForm(BuildContext context,
      {Sale? sale}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SaleDialogForm(sale: sale);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      heading: 'Recent Sales',
      // actions: [
      //   ElevatedButton(
      //     child: const Text("NEW SALE"),
      //     onPressed: () async {
      //       await _showCreateUpdateDialogForm(context);
      //     },
      //   )
      // ],
      child: StreamBuilder<QuerySnapshot>(
          stream: _salesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong!");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            return FutureBuilder(
                future: Sale.findAll(snapshot.data!.docs),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        columns: const [
                          DataColumn(label: Text("Product")),
                          DataColumn(label: Text("Unit Price"), numeric: true),
                          DataColumn(label: Text("Sold"), numeric: true),
                          DataColumn(label: Text("Total Price"), numeric: true),
                          // DataColumn(label: Text('Actions'))
                        ],
                        rows: snapshot.data!.map((e) {
                          return DataRow(cells: [
                            DataCell(Text(e['product'])),
                            DataCell(Text(e['unitPrice'].toString())),
                            DataCell(Text(e['quantity'].toString())),
                            DataCell(Text(e['totalPrice'].toString())),
                            // DataCell(IconButton(
                            //   icon: const Icon(Icons.edit),
                            //   onPressed: () {},
                            // ))
                          ]);
                        }).toList(),
                      ),
                    );
                  }

                  return const Text("Loading");
                });
          }),
    );
  }
}
