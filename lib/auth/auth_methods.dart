import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AuthMethods {
  //signs up user with email & password only
  static void signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    bool anyException = false;
    late BuildContext errorContext;
    late BuildContext overlayContext;
    void closeAllDialogs() {
      if (Navigator.of(errorContext).canPop()) {
        Navigator.of(errorContext).pop();
      }
      if (Navigator.of(overlayContext).canPop()) {
        Navigator.of(overlayContext).pop();
      }
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          overlayContext = context;
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String error = '';

      anyException = true;

      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'An account already exists for that email.';
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            errorContext = context;
            return AlertDialog(
              content: Text(error),
              actions: [
                TextButton(
                    onPressed: () => closeAllDialogs(),
                    child: const Text('CLOSE'))
              ],
            );
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      if (anyException == false) {
        Navigator.of(overlayContext).pop();
        context.go('/');
      }
    }
  }
}
