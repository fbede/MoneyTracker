import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/main.dart';

import '../auth/auth_page.dart';
import 'blocs/navigation_cubit.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationCubit navCubit;

  AppRouter({required this.navCubit});

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<NavigationCubit, NavigationState>(
              listener: (context, state) {})
        ],
        child: BlocConsumer<NavigationCubit, NavigationState>(
          listener: (context, state) {},
          builder: (context, state) => Navigator(
            pages: [
              SignInPage.page(),
              SignUpPage.page(),
              //SplashPage.page(),
            ],
            onPopPage: (route, result) => _onPopPage.call(route, result),
          ),
        ));
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
