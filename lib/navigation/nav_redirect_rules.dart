import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

abstract class NavRules {
  /*specifies navigation rules for when the user is logged in and when they are not*/
  static String? userLoggedInRule(GoRouterState state) {
    // if the user is not logged in, they need to login
    final loggedIn = (FirebaseAuth.instance.currentUser != null);
    final loggingIn = state.subloc == '/logIn';
    final signingUp = state.subloc == '/signUp';
    if (!(loggedIn || signingUp)) return loggingIn ? null : '/logIn';

    // if the user is logged in but still on the login page, send them to
    // the home page
    if ((loggingIn || signingUp) && loggedIn) return '/';

    // no need to redirect at all
    return null;
  }
}
