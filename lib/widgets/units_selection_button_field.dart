import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum UnitType { unit, dozen }

class UnitsSelectionButtonField extends HookWidget {
  final ValueNotifier<UnitType> selectedUnit;

  const UnitsSelectionButtonField({Key? key, required this.selectedUnit})
      : super(key: key);

  _getUnitTypeString(UnitType unitType) {
    return unitType.name == UnitType.unit.name ? 'unit(s)' : 'dozen';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _getUnitTypeString(selectedUnit.value),
      decoration: const InputDecoration(contentPadding: EdgeInsets.all(0)),
      items: const [
        DropdownMenuItem(
          value: 'unit(s)',
          child: Text('unit(s)'),
        ),
        DropdownMenuItem(
          value: 'dozen',
          child: Text('dozen'),
        )
      ],
      onChanged: (val) {
        selectedUnit.value = val! == 'unit(s)' ? UnitType.unit : UnitType.dozen;
      },
    );
  }
}
