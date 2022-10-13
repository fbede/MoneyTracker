import 'package:flutter/material.dart';
import 'package:money_tracker/utils/constants.dart';

class AccountsPage extends StatefulWidget {
  final int index;
  const AccountsPage({Key? key, this.index = 0}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String accountTabName = 'Accounts';
  final String transcationTabName = 'Transcations';
  final String budgetsTabName = 'Budgets';
  final String loansTabName = 'Loans';
  String pageTitle = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    pageTitle = _getPageTitle(index: widget.index);
    _tabController.addListener(() {
      setState(() {
        pageTitle = _getPageTitle(index: _tabController.index);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            pageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(text: 'Accounts'),
            Tab(text: 'Transcations'),
            Tab(text: 'Budgets'),
            Tab(text: 'Loans'),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [Text('yo'), Text('yo'), Text('yo'), Text('yo')],
        ),
      ),
    );
  }

  String _getPageTitle({required int index}) {
    switch (index) {
      case 0:
        return accountTabName;
      case 1:
        return transcationTabName;
      case 2:
        return budgetsTabName;
      case 3:
        return loansTabName;
      default:
        return appName;
    }
  }
}

List<Widget> yo = [
  AccountsView(),
  TranscationsView(),
  BudgetView(),
  LoanView()
];

class LoanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class BudgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class TranscationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AccountsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
