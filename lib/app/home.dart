import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/app/accounts/accounts_page.dart';
import 'package:money_tracker/app/dashboard/dashboard_page.dart';
import 'package:money_tracker/app/reports/reports_page.dart';
import 'package:money_tracker/app/settings/settings_page.dart';
import 'package:money_tracker/navigation/main_routes.dart';

class HomePage extends StatefulWidget {
  final int pageIndex;
  const HomePage({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: Add actual pages to list below
  final pages = <Widget>[
    const DashboardPage(),
    const AccountsPage(),
    //this sizedbox is a placeholder for null and is never called/created
    const SizedBox(height: 0, width: 0),
    const ReportsPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.pageIndex;

    return SafeArea(
        child: Scaffold(
      body: IndexedStack(
        index: currentIndex,
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
          currentIndex: currentIndex,
          onTap: (index) {
            if (index != 2) {
              _goToPage(index);
            }
          },
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

  void _goToPage(int index) {
    switch (index) {
      case 0:
        context.goNamed(dashboardPath);
        break;
      case 1:
        context.goNamed(accountsPath);
        break;
      case 3:
        context.goNamed(reportsPath);
        break;
      case 4:
        context.goNamed(settingsPath);
        break;
      default:
        context.goNamed(homePath);
    }
  }
}
