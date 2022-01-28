import 'package:flutter/material.dart';
import '../palette.dart';

class MyIconButton extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const MyIconButton(
      {Key? key, required this.primaryColor, required this.secondaryColor})
      : super(key: key);

  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  Color _containerPrimaryColor = Palette.purpleDark;
  Color _containerSecondaryColor = Palette.purpleLight;

  @override
  void initState() {
    super.initState();
    _containerPrimaryColor = widget.primaryColor;
    _containerSecondaryColor = widget.secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: _containerSecondaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              color: _containerPrimaryColor,
              hoverColor: _containerPrimaryColor,
              splashRadius: null,
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {}),
        ),
        onTap: () {},
        onHover: (bool isHovering) {
          setState(() {
            _containerPrimaryColor =
                isHovering ? widget.secondaryColor : widget.primaryColor;
            _containerSecondaryColor =
                isHovering ? widget.primaryColor : widget.secondaryColor;
          });
        },
      ),
    );
  }
}
