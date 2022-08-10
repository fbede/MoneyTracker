import 'regex_patterns.dart';
export 'general_input_validators.dart';

//ensures the user put an email
String? validateEmail(String email) {
  if (emailRegExPattern.hasMatch(email)) {
    return null;
  }
  return 'Please enter an email address';
}

//ensures the password length is up to 7
String? checkPasswordLength(String v) {
  if (v.length < 7) {
    return 'Password is too short';
  }
  return null;
}

//ensures that password and confirm password are the same
String? confirmPasswordsAreTheSame(
    {required String password, required String confirmPassword}) {
  if (confirmPassword != password) {
    return 'Please confirm both passwords are the same';
  }
  return null;
}
