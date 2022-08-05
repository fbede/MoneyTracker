import 'package:flutter/material.dart';
import 'package:money_tracker/dashboard/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // TODO: Add actual pages to list below
  final pages = <Widget>[
    const DashboardPage(),
  ];

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
        label: const Text('Add'),
        onPressed: _openBottomSheet,
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
                if (index != 2) {
                  _currentIndex = index;
                }
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_filled),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined),
                activeIcon: Icon(Icons.menu),
                label: 'Accounts'),
            BottomNavigationBarItem(
                icon: SizedBox(), activeIcon: SizedBox(), label: ''),
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
