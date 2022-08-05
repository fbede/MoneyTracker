import 'package:flutter/material.dart';

import '../utils/responsive_page.dart';
import 'signup_page_body.dart';

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
            body: Center(
      child: SizedBox(
        width: 300,
        child: Card(
          child: Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              child: getSignUpPageBody()),
        ),
      ),
    )));
  }
}
