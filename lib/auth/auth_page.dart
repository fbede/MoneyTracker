import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/auth/login_page_body.dart';

import '../home.dart';
import '../navigation/app_pages.dart';
import '../utils/responsive_page.dart';
import 'signup_page_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return const SignInPage();
        });
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.signUpPath,
      key: ValueKey(AppPages.signUpPath),
      child: const SignUpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobileSignUpPage(), const _DesktopSignUpPage());
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.signInPath,
      key: ValueKey(AppPages.signInPath),
      child: const SignInPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobileLoginPage(), const _DesktopLoginPage());
  }
}

class _MobileSignUpPage extends StatelessWidget {
  const _MobileSignUpPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
      child: Center(
        child: getSignUpPageBody(),
      ),
    )));
  }
}

class _DesktopSignUpPage extends StatelessWidget {
  const _DesktopSignUpPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
      child: Center(
        child: getSignUpPageBody(),
      ),
    )));
  }
}

class _MobileLoginPage extends StatelessWidget {
  const _MobileLoginPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
      child: Center(
        child: getLoginPageBody(),
      ),
    )));
  }
}

class _DesktopLoginPage extends StatelessWidget {
  const _DesktopLoginPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
      child: Center(
        child: getLoginPageBody(),
      ),
    )));
  }
}
