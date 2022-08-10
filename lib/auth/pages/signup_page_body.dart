import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/utils/general_input_validators.dart';

import '../auth_methods.dart' as auth_functions;
import '../auth_methods.dart';
import 'login_page_body.dart';

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({Key? key}) : super(key: key);
  @override
  State<SignUpPageBody> createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
  String email = '';
  String password = '';
  String cpassword = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 8),
        buildIcon(),
        const SizedBox(height: 8),
        _buildTitle(),
        const SizedBox(height: 32),
        _buildForm(),
        const SizedBox(height: 24),
        _buildSignUpButton(),
        const SizedBox(height: 32),
        buildSocialSignIn(context: context),
        _buildBottomText()
      ]),
    );
  }

  Widget _buildTitle() => Center(
        child: Text(
          'Create Account',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
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
            onChanged: (v) => setState(() {
              email = v;
            }),
            validator: (value) => validateEmail(value!),
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
                prefixIcon: Icon(Icons.key)),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            onChanged: (v) => setState(() {
              password = v;
            }),
            validator: (v) => checkPasswordLength(v!),
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Confirm Password'),
                prefixIcon: Icon(Icons.key)),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            onChanged: (v) => setState(() {
              cpassword = v;
            }),
            validator: (v) => confirmPasswordsAreTheSame(
                password: password, confirmPassword: cpassword),
          )
        ],
      ));

  Widget _buildSignUpButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
        onPressed: () => auth_functions.signUpWithEmail(
            context: context, email: email, password: password),
        child: const Text('Sign Up'),
      );

  Widget _buildBottomText() => RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              text: 'Have Account? ',
              children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.go('/logIn'),
                text: 'Sign In',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary)),
            TextSpan(
                style: Theme.of(context).textTheme.bodyLarge, text: ' or '),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => skipSignUp(context: context),
                text: 'Skip',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary)),
          ]));
}
