import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:money_tracker/home.dart';

import '../auth/login_page_body.dart';
import '../auth/signup_page.dart';

final appRoutes = <GoRoute>[
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
];
