import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // TODO: Add actual pages to list below
  final pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        //isExtended: true,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        onPressed: _openBottomSheet,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize_outlined),
                activeIcon: Icon(Icons.dashboard_customize),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined),
                activeIcon: Icon(Icons.menu),
                label: 'Accounts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_outlined),
                activeIcon: Icon(Icons.receipt),
                label: 'Reports'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings')
          ]),
    ));
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              children: const <Widget>[
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Cooling'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Cooling'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Cooling'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Cooling'),
                ),
              ],
            ),
          );
        });
  }
}
