import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function handleSubmit;

  const ConfirmationDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.handleSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
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
            onPressed: () async {
              await handleSubmit();

              Navigator.of(context).pop();
            },
            child: const Text('SUBMIT'))
      ],
    );
  }
}
