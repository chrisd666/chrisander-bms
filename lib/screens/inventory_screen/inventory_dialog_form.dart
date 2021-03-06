import 'package:bms/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils.dart';
import '../../widgets/units_selection_button_field.dart';

class InventoryDialogForm extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final Product? product;

  InventoryDialogForm({Key? key, this.product}) : super(key: key);

  void _disposeControllers() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedUnit = useState<UnitType>(UnitType.unit);
    final updatedUnitsInStock =
        useState(product == null ? 0 : product!.unitsInStock);

    void handleUpdatedUnits(ValueNotifier<int> updatedUnitsInStock,
        ValueNotifier<UnitType> selectedUnit) {
      if (_quantityController.text != "") {
        updatedUnitsInStock.value = getNoOfUnits(
            int.parse(_quantityController.text), selectedUnit.value);
      }
    }

    useEffect(() {
      _nameController.text = product == null ? "" : product!.name;
      _quantityController.text =
          product == null ? "" : product!.unitsInStock.toString();
      _priceController.text =
          product == null ? "" : product!.unitPrice.toString();

      _quantityController.addListener(() {
        handleUpdatedUnits(updatedUnitsInStock, selectedUnit);
      });

      selectedUnit.addListener(() {
        handleUpdatedUnits(updatedUnitsInStock, selectedUnit);
      });

      return _disposeControllers;
    }, [_quantityController, selectedUnit]);

    Future<void> addProduct() {
      return Product(
              name: _nameController.text,
              unitsInStock: updatedUnitsInStock.value,
              unitPrice: int.parse(_priceController.text))
          .add();
    }

    Future<void> updateProduct() {
      return Product.update(product!.id!, {
        "name": _nameController.text,
        "unitsInStock": updatedUnitsInStock.value,
        "unitPrice": int.parse(_priceController.text)
      });
    }

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          "${product == null ? "Add" : "Update"} Product",
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
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
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
                            contentPadding: EdgeInsets.all(0)),
                      ),
                    ),
                    Expanded(
                      child:
                          UnitsSelectionButtonField(selectedUnit: selectedUnit),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "CANCEL",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }

                if (product == null) {
                  addProduct();
                } else {
                  updateProduct();
                }
              },
              child: const Text('SUBMIT')),
        ],
      );
    });
  }
}
