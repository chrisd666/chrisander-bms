import 'package:bms/widgets/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bms/models/product.dart';

class InventoryScreenPresentation extends StatelessWidget {
  final Function(BuildContext context, {Product? product})
      showCreateUpdateDialogForm;
  final Function(BuildContext context,
      {required String productId,
      required String productName,
      required Function handleDelete}) showDeleteProductDialog;
  final Stream<QuerySnapshot> products;

  const InventoryScreenPresentation(
      {Key? key,
      required this.products,
      required this.showCreateUpdateDialogForm,
      required this.showDeleteProductDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Layout(
        heading: "Inventory",
        actions: [
          ElevatedButton(
              child: const Text("ADD PRODUCT"),
              onPressed: () async {
                await showCreateUpdateDialogForm(context);
              })
        ],
        child: StreamBuilder<QuerySnapshot>(
            stream: products,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong!");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }

              return DataTable(
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                columns: const [
                  DataColumn(label: Text("Item")),
                  DataColumn(label: Text("Price"), numeric: true),
                  DataColumn(label: Text("Quantity"), numeric: true),
                  DataColumn(label: Text("Actions")),
                ],
                rows: snapshot.data!.docs
                    .map((DocumentSnapshot product) => DataRow(cells: [
                          DataCell(Text(product['name'])),
                          DataCell(Text(product['price'].toString())),
                          DataCell(Text(product['quantity'].toString())),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () async {
                                  await showCreateUpdateDialogForm(context,
                                      product: Product(
                                          id: product.id,
                                          name: product['name'],
                                          price: product['price'],
                                          quantity: product['quantity']));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Theme.of(context).colorScheme.error,
                                onPressed: () async {
                                  showDeleteProductDialog(context,
                                      productId: product.id,
                                      productName: product['name'],
                                      handleDelete: () =>
                                          Product.delete(product.id));
                                },
                              ),
                            ],
                          )),
                        ]))
                    .toList(),
              );
            }),
      ),
    );
  }
}
