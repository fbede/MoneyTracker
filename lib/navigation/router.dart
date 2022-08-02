import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/navigation/cubit/navigation_cubit.dart';

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
            pages: state.pages,
          ),
        ));
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
