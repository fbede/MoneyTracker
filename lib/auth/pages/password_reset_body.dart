import 'package:flutter/material.dart';
import 'package:money_tracker/utils/general_input_validators.dart';

import '../auth_methods.dart';

class PasswordResetPageBody extends StatefulWidget {
  const PasswordResetPageBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPageBody> {
  String email = '';
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'A link will be sent to your email',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                onPressed: () =>
                    resetPasswordEmail(buildContext: context, email: email),
                child: const Text('Reset'),
              )
            ],
          ),
        ),
      );
}
