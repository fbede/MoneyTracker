import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getLoginPageBody() {
  return const _MobileLoginPage();
}

class _MobileLoginPage extends StatefulWidget {
  const _MobileLoginPage();
  @override
  State<_MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<_MobileLoginPage> {
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
                          recognizer:
                              TapGestureRecognizer(), //..onTap = widget.toggleAuthPages,
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
