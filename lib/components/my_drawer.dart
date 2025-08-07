import 'package:flutter/material.dart';
import 'package:notw/components/drawer_tile.dart';
import 'package:notw/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          DrawerHeader(child: Icon(Icons.edit)),

          SizedBox(height: 25),

          //Note tile
          DrawerTile(
            title: 'Note',
            leading: Icon(Icons.note),
            onTap: () => Navigator.pop(context),
          ),

          //settings tile
          DrawerTile(
            title: 'Setting',
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
