import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildMenuItems(context),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    return <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: const Text(
          'Globo Fitness',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        title: const Text('Home'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
      ),
      ListTile(
        title: const Text('BMI Calculator'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/calculator');
        },
      ),
      ListTile(
        title: const Text('Weather'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/weather');
        },
      ),
      ListTile(
        title: const Text('Training'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/training');
        },
      ),
    ];
  }
}
