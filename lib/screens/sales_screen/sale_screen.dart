import 'package:bms/screens/sales_screen/sale_dialog_form.dart';
import 'package:bms/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:bms/models/sale.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({Key? key}) : super(key: key);

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
      actions: [
        ElevatedButton(
          child: const Text("NEW SALE"),
          onPressed: () async {
            await _showCreateUpdateDialogForm(context);
          },
        )
      ],
      child: DataTable(
        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        columns: const [
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Unit Price")),
          DataColumn(label: Text("Sold")),
          DataColumn(label: Text("Sold At"))
        ],
        rows: [],
      ),
    );
  }
}
