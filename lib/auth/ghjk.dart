import 'package:flutter/material.dart';

class HomerPage extends StatefulWidget {
  const HomerPage({Key? key}) : super(key: key);

  @override
  State<HomerPage> createState() => _HomerPageState();
}

class _HomerPageState extends State<HomerPage> {
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
            floatingActionButton: FloatingActionButton(
              isExtended: true,
              child: const Icon(Icons.add),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTabItem(
                      index: 0, icon: const Icon(Icons.dashboard_customize)),
                  buildTabItem(index: 1, icon: const Icon(Icons.wallet)),
                  buildTabItem(
                      index: 2, icon: const Icon(Icons.dashboard_customize)),
                  buildTabItem(
                      index: 3, icon: const Icon(Icons.dashboard_customize))
                ],
              ),
            )));
  }

  Widget buildTabItem({required int index, required Icon icon}) {
    return IconButton(onPressed: () {}, icon: icon);
  }
}
