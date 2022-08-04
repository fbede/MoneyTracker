import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/auth/auth_page.dart';
import 'package:money_tracker/home.dart';

final appRoutes = <GoRoute>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
  ),
  GoRoute(
    path: '/signIn',
    builder: (BuildContext context, GoRouterState state) {
      return const SignInPage();
    },
  ),
  GoRoute(
    path: '/signUp',
    builder: (BuildContext context, GoRouterState state) {
      return const SignUpPage();
    },
  ),
];
