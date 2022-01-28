import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Chrisander Wines Q',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Sales'),
          ),
          ListTile(
            leading: Icon(Icons.inventory_2_outlined),
            title: Text('Inventory'),
          ),
        ],
      ),
    );
  }
}
