import 'package:bms/models/sale.dart';
import 'package:flutter/material.dart';

class SaleDialogForm extends StatefulWidget {
  final Sale? sale;

  const SaleDialogForm({Key? key, this.sale}) : super(key: key);

  @override
  _SaleDialogFormState createState() => _SaleDialogFormState();
}

class _SaleDialogFormState extends State<SaleDialogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _productController.text = widget.sale == null ? "" : widget.sale!.productId;
    _quantityController.text =
        widget.sale == null ? "" : widget.sale!.quantity.toString();
    _priceController.text =
        widget.sale == null ? "" : widget.sale!.totalPrice.toString();
  }

  @override
  void dispose() {
    super.dispose();

    _productController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addSale() {
      return Sale(
              productId: _productController.text,
              quantity: int.parse(_quantityController.text),
              totalPrice: int.parse(_priceController.text))
          .add();
    }

    Future<void> updateSale() {
      return Sale(
              id: widget.sale!.id,
              productId: _productController.text,
              quantity: int.parse(_quantityController.text),
              totalPrice: int.parse(_priceController.text))
          .update();
    }

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          "${widget.sale == null ? "Add" : "Update"} Sale",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _productController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid Field";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Product name",
                  ),
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid Field";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Price",
                  ),
                ),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid Field";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Quantity",
                  ),
                )
              ],
            )),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }

                if (widget.sale == null) {
                  addSale();
                } else {
                  updateSale();
                }
              },
              child: const Text('SUBMIT'))
        ],
      );
    });
  }
}
