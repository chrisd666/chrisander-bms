import 'package:bms/models/sale.dart';
import 'package:bms/models/product.dart';
import 'package:bms/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SaleDialogForm extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final Sale? sale;
  final Product? product;

  SaleDialogForm({Key? key, this.sale, this.product}) : super(key: key);

  void _disposeControllers() {
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? _totalPrice;
    int _unitsInStock = 0;

    void _handleTotalPrice() {
      if (product != null && isNumeric(_quantityController.text)) {
        int totalPrice =
            product!.unitPrice * int.parse(_quantityController.text);

        _totalPrice = totalPrice;
      } else {
        _totalPrice = 0;
      }
    }

    Future<void> _addSale() {
      int totalSales = product!.totalSales == null
          ? 0
          : product!.totalSales! + int.parse(_quantityController.text);

      return Sale(
              productId: product!.id!,
              quantity: int.parse(_quantityController.text),
              totalPrice: _totalPrice!)
          .add()
          .then((value) {
        Product.update(product!.id!, {
          "unitsInStock": _unitsInStock - int.parse(_quantityController.text),
          "totalSales": totalSales
        });
      });
    }

    // Future<void> updateSale() {
    //   return Sale(
    //           id: sale!.id,
    //           productId: _productController.text,
    //           quantity: int.parse(_quantityController.text),
    //           totalPrice: int.parse(_priceController.text))
    //       .update();
    // }

    useEffect(() {
      _quantityController.text = sale == null ? "" : sale!.quantity.toString();
      _quantityController.addListener(_handleTotalPrice);
      _unitsInStock = product == null ? 0 : product!.unitsInStock;

      return _disposeControllers;
    }, []);

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          "${sale == null ? "Add" : "Update"} Sale",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (product != null)
                  Text(
                    product!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                if (product != null)
                  Text(
                    'Unit Price: Rs. ${product!.unitPrice}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                // StreamBuilder<QuerySnapshot>(
                //     stream: _products,
                //     builder: (context, snapshot) {
                //       print(snapshot.hasData);

                //       return Autocomplete(
                //         optionsBuilder: (textEditingValue) {
                //           if (textEditingValue.text == '') {
                //             print('in 1st');

                //             return const Iterable<String>.empty();
                //           }

                //           if (snapshot.hasData) {
                //             print('in 2nd');

                //             return snapshot.data!.docs.where((e) {
                //               String productName = e.data().toString();

                //               return productName.contains(
                //                   textEditingValue.text.toLowerCase());
                //             });
                //           }

                //           return const Iterable<String>.empty();
                //         },
                //         onSelected: (selection) {
                //           print(selection);
                //         },
                //       );
                //     }),

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
                ),

                if (_totalPrice != null)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Total Price: Rs. $_totalPrice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[600]),
                    ),
                  ),
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

                if (sale == null) {
                  _addSale();
                } else {
                  // updateSale();
                }
              },
              child: const Text('SUBMIT'))
        ],
      );
    });
  }
}
