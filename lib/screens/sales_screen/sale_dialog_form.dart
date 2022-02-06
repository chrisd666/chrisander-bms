import 'package:bms/models/sale.dart';
import 'package:bms/models/product.dart';
import 'package:bms/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaleDialogForm extends StatefulWidget {
  final Sale? sale;
  final Product? product;

  const SaleDialogForm({Key? key, this.sale, this.product}) : super(key: key);

  @override
  _SaleDialogFormState createState() => _SaleDialogFormState();
}

class _SaleDialogFormState extends State<SaleDialogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  int? _totalPrice;
  int _unitsInStock = 0;

  void _handleTotalPrice() {
    if (widget.product != null && isNumeric(_quantityController.text)) {
      int totalPrice =
          widget.product!.unitPrice * int.parse(_quantityController.text);
      ;
      int unitsInStock = _unitsInStock - totalPrice;

      setState(() {
        _totalPrice = totalPrice;
        _unitsInStock = unitsInStock;
      });
    } else {
      setState(() {
        _totalPrice = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _quantityController.text =
        widget.sale == null ? "" : widget.sale!.quantity.toString();
    _quantityController.addListener(_handleTotalPrice);
    _unitsInStock = widget.product == null ? 0 : widget.product!.unitsInStock;
  }

  @override
  void dispose() {
    super.dispose();

    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _addSale() {
      int totalSales = widget.product!.totalSales == null
          ? 0
          : widget.product!.totalSales! + int.parse(_quantityController.text);

      return Sale(
              productId: widget.product!.id!,
              quantity: int.parse(_quantityController.text),
              totalPrice: _totalPrice!)
          .add()
          .then((value) {
        Product.update(widget.product!.id!,
            {"unitsInStock": _unitsInStock, "totalSales": totalSales});
      });
    }

    // Future<void> updateSale() {
    //   return Sale(
    //           id: widget.sale!.id,
    //           productId: _productController.text,
    //           quantity: int.parse(_quantityController.text),
    //           totalPrice: int.parse(_priceController.text))
    //       .update();
    // }

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
                if (widget.product != null)
                  Text(
                    widget.product!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                if (widget.product != null)
                  Text(
                    'Unit Price: Rs. ${widget.product!.unitPrice}',
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

                if (widget.sale == null) {
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
