import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'auth_methods.dart';

Widget getSignUpPageBody() {
  return const _SignUpPageBody();
}

class _SignUpPageBody extends StatefulWidget {
  const _SignUpPageBody({Key? key}) : super(key: key);
  @override
  State<_SignUpPageBody> createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<_SignUpPageBody> {
  String email = '';
  String password = '';
  String cpassword = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        //const SizedBox(height: 32),
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
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
                  onChanged: (v) => setState(() {
                    email = v;
                  }),
                  validator: (value) {
                    if (value!.contains('@') &&
                        value.length > 4 &&
                        value.contains('.')) {
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
                  onChanged: (v) => setState(() {
                    password = v;
                  }),
                  validator: (v) => _checkPassword(v),
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
                  validator: (v) => _checkPassword(v),
                )
              ],
            )),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () => AuthMethods.signUpWithEmail(
              context: context, email: email, password: password),
          child: const Text('Sign Up'),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          //TODO: Add google signup
          onPressed: () {},
          child: const FaIcon(FontAwesomeIcons.google),
        ),
        const SizedBox(height: 32),
        RichText(
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
                    //TODO: Add anonymous authentication later
                    ..onTap = () => skipSignUp(),
                  text: 'Skip',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary)),
            ]))
      ]),
    );
  }

  _checkPassword(v) {
    if (v.length < 7) {
      return 'Password is too short';
    }
    if (cpassword != password) {
      return 'Please confirm both passwords are the same';
    }
    return null;
  }

//TODO: Add Google, Microsoft & Apple Auth Later
  void signInWithGoogle() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      //await FirebaseAuth.instance.signInWithCredential(credential)
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void skipSignUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
