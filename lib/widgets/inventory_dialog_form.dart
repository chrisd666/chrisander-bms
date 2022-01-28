import 'package:bms/models/product_model.dart';
import 'package:flutter/material.dart';

class InventoryDialogForm extends StatefulWidget {
  final Product? product;

  const InventoryDialogForm({Key? key, this.product}) : super(key: key);

  @override
  _InventoryDialogFormState createState() => _InventoryDialogFormState();
}

class _InventoryDialogFormState extends State<InventoryDialogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.product == null ? "" : widget.product!.name;
    _quantityController.text =
        widget.product == null ? "" : widget.product!.price.toString();
    _priceController.text =
        widget.product == null ? "" : widget.product!.quantity.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addProduct() {
      return Product.productsRef
          .add(Product(
              name: _nameController.text,
              quantity: int.parse(_quantityController.text),
              price: int.parse(_priceController.text)))
          .then((value) => print("Product added"))
          .catchError((error) => print("Failed to add product: $error"));
    }

    print(widget.product);

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          "${widget.product == null ? "Add" : "Update"} Product",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
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

                addProduct();
              },
              child: const Text('SUBMIT'))
        ],
      );
    });
  }
}
