import 'package:flutter/material.dart';

import '../utils/responsive_page.dart';
import 'login_page_body.dart';
import 'pages/password_reset_body.dart';
import 'signup_page_body.dart';

// This shows the Login Page
class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobileLogInPage(), const _DesktopLoginPage());
  }
}

class _MobileLogInPage extends StatelessWidget {
  const _MobileLogInPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ResponsivePage.optionalAppBar(),
            body: const Padding(
              padding: EdgeInsetsDirectional.only(start: 32.0, end: 32.0),
              child: Center(
                child: LoginPageBody(),
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
            appBar: ResponsivePage.optionalAppBar(),
            body: const Center(
              child: SizedBox(
                width: 350,
                child: Card(
                  child: Padding(
                      padding: EdgeInsetsDirectional.all(16.0),
                      child: SignUpPageBody()),
                ),
              ),
            )));
  }
}

//This shows the SignUp Page
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobileSignUpPage(), const _DesktopSignUpPage());
  }
}

class _MobileSignUpPage extends StatelessWidget {
  const _MobileSignUpPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ResponsivePage.optionalAppBar(),
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 32.0, end: 32.0),
                child: Center(
                  child: SingleChildScrollView(child: SignUpPageBody()),
                ),
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
            appBar: ResponsivePage.optionalAppBar(),
            body: const Center(
              child: SizedBox(
                width: 350,
                child: Card(
                  child: Padding(
                      padding: EdgeInsetsDirectional.all(16.0),
                      child: SignUpPageBody()),
                ),
              ),
            )));
  }
}

//This shows the Password Reset Page
class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobilePasswordResetPage(), const _DesktopPasswordResetPage());
  }
}

class _MobilePasswordResetPage extends StatelessWidget {
  const _MobilePasswordResetPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ResponsivePage.optionalAppBar(),
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 32.0, end: 32.0),
                child: Center(
                  child: SingleChildScrollView(child: PasswordResetPageBody()),
                ),
              ),
            )));
  }
}

class _DesktopPasswordResetPage extends StatelessWidget {
  const _DesktopPasswordResetPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ResponsivePage.optionalAppBar(),
            body: const Center(
              child: SizedBox(
                width: 350,
                child: Card(
                  child: Padding(
                      padding: EdgeInsetsDirectional.all(16.0),
                      child: PasswordResetPageBody()),
                ),
              ),
            )));
  }
}
