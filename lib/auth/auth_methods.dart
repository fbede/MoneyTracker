import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/utils/exceptions/exceptions_barrel.dart';

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
    } on Exception catch (e) {
      anyException = true;
      anyException = true;
      _showAlertDialog(
          buildContext: context,
          errorMessage: ExeceptionHandler.errorMessageFromError(exception: e));
    } finally {
      if (anyException == false) {
        _closeAllDialogs();
        context.go('/');
      }
    }
  }

// this is meant to handle all the auths
//started working on it because the auth method seemed repeative
//TODO complete after signIn
  static void handleAllAuth(
      {required BuildContext context,
      required Function authFunction,
      List<Function> finallyBlock = const [],
      String email = '',
      String password = ''}) async {
    _showLoadingDialog(buildContext: context);
    anyException = false;
    try {
      authFunction;
    } on Exception catch (e) {
      anyException = true;
      _showAlertDialog(
          buildContext: context,
          errorMessage: ExeceptionHandler.errorMessageFromError(exception: e));
    }
  }

  //Reset Password with email
  static void resetPasswordEmail(
      {required BuildContext buildContext, required String email}) async {
    _showLoadingDialog(buildContext: buildContext);
    anyException = false;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showAlertDialog(
          buildContext: buildContext,
          errorMessage: 'The email has been sent',
          shouldPopPage: true);
    } on Exception catch (e) {
      anyException = true;
      _showAlertDialog(
          buildContext: buildContext,
          errorMessage: ExeceptionHandler.errorMessageFromError(exception: e));
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
      {required BuildContext buildContext,
      required String errorMessage,
      bool shouldPopPage = false}) {
    showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (context) {
          dialogsThatAreOpen.add(context);
          return AlertDialog(
            content: Text(errorMessage),
            actions: [
              TextButton(
                  onPressed: () => {
                        _closeAllDialogs(),
                        if (shouldPopPage) {buildContext.pop()}
                      },
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
}
