import 'package:bms/models/product.dart';
import 'package:bms/screens/inventory_screen/inventory_screen_presentation.dart';
import 'package:bms/widgets/confirmation_dialog.dart';
import 'package:bms/widgets/inventory_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _productsStream = Product.productsRef.snapshots();

  InventoryScreen({Key? key}) : super(key: key);

  Future<void> _showCreateUpdateDialogForm(BuildContext context,
      {Product? product}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return InventoryDialogForm(product: product);
        });
  }

  Future<void> _showDeleteProductDialog(BuildContext context,
      {required String productId,
      required String productName,
      required Function handleDelete}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ConfirmationDialog(
            title: 'Delete Product: $productName',
            description: 'Are you sure you want to delete this product?',
            handleSubmit: () async => await Product.delete(productId),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: InventoryScreenPresentation(
        products: _productsStream,
        showCreateUpdateDialogForm: _showCreateUpdateDialogForm,
        showDeleteProductDialog: _showDeleteProductDialog,
      ),
    );
  }
}
