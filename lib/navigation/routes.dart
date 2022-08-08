import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:money_tracker/home.dart';

import '../auth/auth_pages.dart';

final appRoutes = <GoRoute>[
  //Todo Change home route based on whether user is logged in or not
  // refactor app to work with new changes
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
  ),
  GoRoute(
    path: '/logIn',
    builder: (BuildContext context, GoRouterState state) {
      return const LogInPage();
    },
  ),
  GoRoute(
    path: '/signUp',
    builder: (BuildContext context, GoRouterState state) {
      return const SignUpPage();
    },
  ),
  GoRoute(
    path: '/resetPassword',
    builder: (BuildContext context, GoRouterState state) {
      return const PasswordResetPage();
    },
  ),
];
