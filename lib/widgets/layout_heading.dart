import 'package:flutter/material.dart';

class LayoutHeading extends StatelessWidget {
  final String heading;
  final List<Widget>? actions;

  const LayoutHeading({Key? key, required this.heading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: Theme.of(context).textTheme.headline5,
          ),
          if (actions != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actions!.map((e) => e).toList(),
            )
        ],
      ),
    );
  }
}
