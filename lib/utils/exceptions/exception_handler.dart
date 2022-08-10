import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:money_tracker/utils/exceptions/exception_codes.dart';
import 'package:money_tracker/utils/exceptions/exception_responses.dart';

export 'exception_handler.dart' show errorMessageFromError;

String errorMessageFromError({required Exception exception}) {
  if (kDebugMode) {
    print(exception);
  }
  if (exception is FirebaseAuthException) {
    return _handleFirebaseAuthException(exception);
  } else if (exception is SocketException) {
    return 'Could not connect to the server. Please check your internet connection';
  } else {
    return exception.toString();
  }
}

String _handleFirebaseAuthException(FirebaseAuthException e) {
//converts the firebase exception to errors

  String errorMessage = '';
  switch (e.code) {
    case weakPasswordErrCode:
      errorMessage = weakPasswordResponse;
      break;
    case emailInUseErrCode:
      errorMessage = emailInUseResponse;
      break;
    case failedNetworkRequestErrCode:
      errorMessage = noInternetResponse;
      break;
    case invalidEmailErrCode:
      errorMessage = invalidEmailResponse;
      break;
    case wrongPasswordErrCode:
      errorMessage = wrongPasswordResponse;
      break;
    case userNotFoundErrCode:
      errorMessage = userEmailNotFoundResponse;
      break;
    case userDisabledErrCode:
      errorMessage = userDisabledResponse;
      break;
    case tooManyRequestErrCode:
      errorMessage = tooManyRequestResponse;
      break;
    case operationNotAllowedErrCode:
      errorMessage = operationNotAllowedResponse;
      break;

    default:
      errorMessage = e.code;
  }
  return errorMessage;
}
