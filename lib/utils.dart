import 'package:bms/widgets/units_selection_button_field.dart';

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

int getNoOfUnits(int units, UnitType unitType) {
  if (unitType == UnitType.dozen) {
    return units * 12;
  }

  return units;
}
