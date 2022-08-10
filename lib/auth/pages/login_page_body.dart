import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../utils/regex_patterns.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        buildIcon(),
        const SizedBox(height: 32),
        _buildTitle(),
        const SizedBox(height: 32),
        _buildForm(),
        _buildSignInButton(),
        const SizedBox(height: 32),
        buildSocialSignIn(),
        const SizedBox(height: 32),
        _buildBottomText()
      ]),
    );
  }

  Widget _buildTitle() => Center(
        child: Text(
          'Money Tracker',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      );

  Widget _buildForm() => Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
                prefixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (emailRegExPattern.hasMatch(value!)) {
                return null;
              }
              return 'Please enter an email address';
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
                prefixIcon: Icon(Icons.key)),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push('/resetPassword'),
                  text: 'Forgot Password',
                  style: TextStyle(
                      //fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary))),
          const SizedBox(height: 16),
        ],
      ));

  Widget _buildSignInButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
        onPressed: () {},
        child: const Text('Sign In'),
      );

  Widget _buildBottomText() => RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              text: 'No Account? ',
              children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.push('/signUp'),
                text: 'Sign Up',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary)),
            TextSpan(
                style: Theme.of(context).textTheme.bodyLarge, text: ' or '),
            TextSpan(
                recognizer: TapGestureRecognizer(),
                //TODO: Add anonymous authentication later
                //..onTap = widget.openLoginPage,
                text: 'Skip',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary)),
          ]));
}

Widget buildIcon() => const FittedBox(
      fit: BoxFit.scaleDown,
      child: Icon(
        Icons.monetization_on,
        size: 150,
      ),
    );

Widget buildSocialSignIn() => ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
      //TODO: Add google signup
      onPressed: () {},
      child: const FaIcon(FontAwesomeIcons.google),
    );
