import 'package:bms/palette.dart';
import 'package:bms/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          MyIconButton(
              primaryColor: Palette.purpleDark,
              secondaryColor: Palette.purpleLight)
        ],
      ),
    );
  }
}
