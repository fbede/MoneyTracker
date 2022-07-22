import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/home.dart';

import '../utils/responsive_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return const HomePage();
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
          return ResponsivePage.buildResponsivePage(
              _MobileLoginPage(), _DesktopLoginPage());
        });
  }
}

class _MobileLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Hell0, How are you');
  }
}

class _DesktopLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
