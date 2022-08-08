import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

abstract class NavRules {
  //specifies navigation rules for when the user is logged in
  //and when they are not
  static String? userLoggedInRule(GoRouterState state) {
    // if the user is not logged in, they need to login
    final isLoggedIn = (FirebaseAuth.instance.currentUser != null);
    final isOnAuthPage = (state.subloc == '/logIn' ||
        state.subloc == '/signUp' ||
        state.subloc == '/resetPassword');
    final isLoggingIn = state.subloc == '/logIn';
    final isSigningUp = state.subloc == '/signUp';
    final isResetingPassword = state.subloc == '/resetPassword';

    // if the user is logged in but still on any of the auth pages,
    //send them to the home page
    if (isLoggedIn && isOnAuthPage) {
      return '/';
    }

    // if user is not logged in and is not on  using any
    // auth page make him login
    if (!isLoggedIn && !isOnAuthPage) {
      return '/logIn';
    }

    // no need to redirect at all
    return null;
  }
}
