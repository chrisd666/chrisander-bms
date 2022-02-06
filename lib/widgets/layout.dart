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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chrisander Wines, Quepem"),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            child: Text(
              "Chrisander Wines, Quepem",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            title: const Text('Inventory'),
            leading: const Icon(Icons.inventory),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Sales'),
            leading: const Icon(Icons.money),
            onTap: () {
              Navigator.pushNamed(context, 'sales');
            },
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(children: [
            if (heading != null)
              LayoutHeading(
                heading: heading!,
                actions: actions,
              ),
            child
          ]),
        ),
      ),
    );
  }
}
