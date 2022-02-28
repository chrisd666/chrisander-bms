import 'package:bms/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InventoryLogScreen extends HookWidget {
  const InventoryLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      heading: 'Inventory Logs',
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white10),
            child: Row(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
