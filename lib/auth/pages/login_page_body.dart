import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/auth/auth_methods.dart';
import 'package:money_tracker/utils/general_input_validators.dart';

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
        buildSocialSignIn(context: context),
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
            onChanged: (v) => setState(() => email = v),
            validator: (value) => validateEmail(value!),
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
                prefixIcon: Icon(Icons.key)),
            onChanged: (v) => setState(() => password = v),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push('/resetPassword'),
                  text: 'Forgot Password',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary))),
          const SizedBox(height: 16),
        ],
      ));

  Widget _buildSignInButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
        onPressed: () =>
            signInWithEmail(context: context, email: email, password: password),
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
                recognizer: TapGestureRecognizer()
                  ..onTap = (() => skipSignUp(context: context)),
                text: 'Skip',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      );
}

Widget buildIcon() => const FittedBox(
      fit: BoxFit.scaleDown,
      child: Icon(
        Icons.monetization_on,
        size: 150,
      ),
    );

Widget buildSocialSignIn({required BuildContext context}) {
  // ignore: dead_code
  if (true) {
    // use line below instead of false for when Google auth is working on all platforms
    //Platform.isIOS || Platform.isAndroid
    return Column(
      children: [
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          onPressed: () => googleSignIn(buildContext: context),
          child: const FaIcon(FontAwesomeIcons.google),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
  return const SizedBox(height: 0);
}
