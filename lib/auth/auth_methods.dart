import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/regex_patterns.dart';

/// ! If any of the dialogs on authpages have issues, especially with
/// ! popping the wrong context, kindly check here. The issue
/// ! would most likely be that a method here is modifiying the
/// ! global buildcontext variables. a quick solution would be to
/// ! make these variables local to the different methods. I didn't do
/// ! that earlier because:
/// ! 1. I'm trying to make the codebase as DRY as possible
/// ! 2. Doing that would involve repeating the dialog behaviour in
/// ! every auth method */
abstract class AuthMethods {
  static final dialogsThatAreOpen = <BuildContext>[];
  static bool anyException = false;

  //ensures the user put an email
  static String? validateEmail(String email) {
    if (emailRegExPattern.hasMatch(email)) {
      return null;
    }
    return 'Please enter an email address';
  }

  //ensures the password length is up to 7
  static String? checkPasswordLength(String v) {
    if (v.length < 7) {
      return 'Password is too short';
    }
    return null;
  }

  //ensures that password and confirm password are the same
  static String? confirmPasswordsAreTheSame(
      {required String password, required String confirmPassword}) {
    if (confirmPassword != password) {
      return 'Please confirm both passwords are the same';
    }
    return null;
  }

  //signs up user with email & password only
  static void signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    _showLoadingDialog(buildContext: context);
    anyException = false;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      anyException = true;
      _showAlertDialog(
          buildContext: context, errorMessage: _errorCodeToErrorMessage(e));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _showAlertDialog(buildContext: context, errorMessage: e.toString());
    } finally {
      if (anyException == false) {
        _closeAllDialogs();
        context.go('/');
      }
    }
  }

  //Reset Password with email
  static void resetPasswordEmail(
      {required BuildContext buildContext, required String email}) async {
    _showLoadingDialog(buildContext: buildContext);
    anyException = false;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _closeAllDialogs();
    } catch (e) {
      anyException = true;
      if (e is FirebaseAuthException) {
        _showAlertDialog(
            buildContext: buildContext,
            errorMessage: _errorCodeToErrorMessage(e));
      } else if (e is SocketException) {
        _showAlertDialog(
            buildContext: buildContext,
            errorMessage:
                'Could not connect to the server. Please check your internet connection');
      } else {
        _showAlertDialog(
            buildContext: buildContext, errorMessage: e.toString());
      }
      if (kDebugMode) {
        print(e);
      }
    } finally {
      if (anyException == false) {
        buildContext.go('/logIn');
      }
    }
  }

  //TODO: Add Google, Microsoft & Apple Auth Later
  // void signInWithGoogle() async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => const Center(
  //             child: CircularProgressIndicator(),
  //           ));
  //   try {
  //     //await FirebaseAuth.instance.signInWithCredential(credential)
  //   } on FirebaseAuthException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  // void skipSignUp() async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => const Center(
  //             child: CircularProgressIndicator(),
  //           ));
  //   try {
  //     await FirebaseAuth.instance.signInAnonymously();
  //   } on FirebaseAuthException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
  //shows all dialogs
  static void _showLoadingDialog({required BuildContext buildContext}) {
    showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (context) {
          dialogsThatAreOpen.add(context);
          return const Center(child: CircularProgressIndicator());
        });
  }

  static void _showAlertDialog(
      {required BuildContext buildContext, required String errorMessage}) {
    showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (context) {
          dialogsThatAreOpen.add(context);
          return AlertDialog(
            content: Text(errorMessage),
            actions: [
              TextButton(
                  onPressed: () => _closeAllDialogs(),
                  child: const Text('CLOSE'))
            ],
          );
        });
  }

  //closes all open dialogs
  static void _closeAllDialogs() {
    for (var element in dialogsThatAreOpen) {
      if (Navigator.of(element).canPop()) {
        Navigator.of(element).pop();
      }
    }
    dialogsThatAreOpen.clear();
  }

  //converts the firebase exception to errors
  static String _errorCodeToErrorMessage(FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage = 'An account already exists for that email.';
        break;
      case 'network-request-failed':
        errorMessage =
            'Could not connect to the server. Please check your internet connection.';
        break;
      case "ERROR_INVALID_EMAIL":
        errorMessage = 'This is not a valid email address';
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = 'The entered password is wrong';
        break;
      case 'user-not-found':
        errorMessage = 'This email is not linked to any account';
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = 'The account linked to this email has been disabled';
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage =
            'The server is has too many request. Kindly try again later';
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage =
            'What you just tried to do is not allowed. Kindly contact us for help';
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        errorMessage =
            'This email has already been registered to another account';
        break;
      default:
        errorMessage = e.code;
    }
    return errorMessage;
  }
}
