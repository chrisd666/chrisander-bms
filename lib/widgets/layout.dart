import 'package:bms/widgets/layout_heading.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final String? heading;
  final List<Widget>? actions;

  const Layout({Key? key, required this.child, this.heading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(children: [
        if (heading != null)
          LayoutHeading(
            heading: heading!,
            actions: actions,
          ),
        child
      ]),
    );
  }
}
