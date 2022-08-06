import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../utils/responsive_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsivePage.buildResponsivePage(
        const _MobileLogInPage(), const _DesktopLoginPage());
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody();
  @override
  State<_LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 32),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    Icons.monetization_on,
                    size: 150,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Money Tracker',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 32),
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Email'),
                              prefixIcon: Icon(Icons.email)),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.key)),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                        )
                      ],
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {},
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40)),
                  //TODO: Add google signin
                  onPressed: () {},
                  child: const FaIcon(FontAwesomeIcons.google),
                ),
                const SizedBox(height: 32),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        text: 'No Account? ',
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go('/signUp'),
                          text: 'Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary)),
                      TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          text: ' or '),
                      TextSpan(
                          recognizer: TapGestureRecognizer(),
                          //TODO: Add anonymous authentication later
                          //..onTap = widget.openLoginPage,
                          text: 'Skip',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary)),
                    ]))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileLogInPage extends StatelessWidget {
  const _MobileLogInPage();

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

Widget getLoginPageBody() {
  return const _LoginPageBody();
}
