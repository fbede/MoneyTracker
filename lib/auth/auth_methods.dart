import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/utils/exceptions/exception_handler.dart'
    as exception_handler;

/// ! If any of the dialogs on authpages have issues, especially with
/// ! popping the wrong context, kindly check here. The issue
/// ! would most likely be that a method here is modifiying the
/// ! global buildcontext variables. a quick solution would be to
/// ! make these variables local to the different methods. I didn't do
/// ! that earlier because:
/// ! 1. I'm trying to make the codebase as DRY as possible
/// ! 2. Doing that would involve repeating the dialog behaviour in
/// ! every auth method */

final _dialogsThatAreOpen = <BuildContext>[];
bool _anyException = false;

//signs in user with email & password only
void signInWithEmail(
    {required BuildContext context,
    required String email,
    required String password}) async {
  _showLoadingDialog(buildContext: context);
  _anyException = false;
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on Exception catch (e) {
    _anyException = true;
    _anyException = true;
    _showAlertDialog(
        buildContext: context,
        errorMessage: exception_handler.errorMessageFromError(exception: e));
  } finally {
    if (_anyException == false) {
      _closeAllDialogs();
      context.go('/');
    }
  }
}

//signs up user with email & password only
void signUpWithEmail(
    {required BuildContext context,
    required String email,
    required String password}) async {
  _showLoadingDialog(buildContext: context);
  _anyException = false;
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on Exception catch (e) {
    _anyException = true;
    _showAlertDialog(
        buildContext: context,
        errorMessage: exception_handler.errorMessageFromError(exception: e));
  } finally {
    if (_anyException == false) {
      _closeAllDialogs();
      context.go('/');
    }
  }
}

//Reset Password with email
void resetPasswordEmail(
    {required BuildContext buildContext, required String email}) async {
  _showLoadingDialog(buildContext: buildContext);
  _anyException = false;
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    _showAlertDialog(
        buildContext: buildContext,
        errorMessage: 'The email has been sent',
        shouldPopPage: true);
  } on Exception catch (e) {
    _anyException = true;
    _showAlertDialog(
        buildContext: buildContext,
        errorMessage: exception_handler.errorMessageFromError(exception: e));
  }
}

// this is meant to handle all the auths
//started working on it because the auth method seemed repeative
//TODO complete after signIn
void handleAllAuth(
    {required BuildContext context,
    required Function authFunction,
    List<Function> finallyBlock = const [],
    String email = '',
    String password = ''}) async {
  _showLoadingDialog(buildContext: context);
  _anyException = false;
  try {
    authFunction;
  } on Exception catch (e) {
    _anyException = true;
    _showAlertDialog(
        buildContext: context,
        errorMessage: exception_handler.errorMessageFromError(exception: e));
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
void _showLoadingDialog({required BuildContext buildContext}) {
  showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (context) {
        _dialogsThatAreOpen.add(context);
        return const Center(child: CircularProgressIndicator());
      });
}

void _showAlertDialog(
    {required BuildContext buildContext,
    required String errorMessage,
    bool shouldPopPage = false}) {
  showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (context) {
        _dialogsThatAreOpen.add(context);
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
void _closeAllDialogs() {
  for (var element in _dialogsThatAreOpen) {
    if (Navigator.of(element).canPop()) {
      Navigator.of(element).pop();
    }
  }
  _dialogsThatAreOpen.clear();
}
