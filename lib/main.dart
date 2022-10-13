import 'package:universal_io/io.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:money_tracker/navigation/nav_redirect_rules.dart';
import 'package:money_tracker/navigation/main_routes.dart';
import 'package:money_tracker/utils/constants.dart';
import 'package:window_size/window_size.dart';
import 'firebase_options.dart';
import 'utils/color_schemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*shows splashscreen, initialazes other stuff then starts app*/
      home: const SplashPage(),
      //check constants.dart file for details
      title: appName,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          colorScheme: lightColorScheme,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: EasySplashScreen(
        logo: Image.asset('assets/flutter_joke.png'),
        title: Text(
          appName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        showLoader: true,
        loadingText: const Text("Loading..."),
        futureNavigator: futureCall(),
      ),
    );
  }

  // Handles all async operations then starts the actual app
  Future<Widget> futureCall() async {
    WidgetsFlutterBinding.ensureInitialized();

    //set desktop window sizing
    if (!kIsWeb) {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        setWindowTitle(appName);
        setWindowMinSize(const Size(300, 300));
        setWindowMaxSize(Size.infinite);
      }

      //Initialize firebase
      if ((defaultTargetPlatform == TargetPlatform.windows) ||
          (defaultTargetPlatform == TargetPlatform.linux)) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      } else {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      //sets google sign in for desktop
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        await GoogleSignInDart.register(
            clientId:
                '377376525654-gjolf7sehfe09233brlodk5ebqlt4bf7.apps.googleusercontent.com');
      }
    }

    //start actual app
    final GoRouter router = GoRouter(
        routes: appMainRoutes,
        //based on firebase auth
        redirect: (state) => NavRules.userLoggedInRule(state),
        refreshListenable:
            //is need for userLoggedInRule
            GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()));
    return Future.delayed(const Duration(seconds: 6), (() {
      return Builder(
          builder: ((context) => GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              //Used to automatically hide keyboard when filling forms all around the app
              child: TooltipVisibility(
                  visible: false,
                  //This is the actual app
                  child: MaterialApp.router(
                    routeInformationParser: router.routeInformationParser,
                    routeInformationProvider: router.routeInformationProvider,
                    routerDelegate: router.routerDelegate,
                    //repeated the theme here because descendant widgets use this
                    title: appName,
                    themeMode: ThemeMode.system,
                    theme: ThemeData(
                        colorScheme: lightColorScheme,
                        visualDensity: VisualDensity.adaptivePlatformDensity),
                    darkTheme: ThemeData(
                        colorScheme: darkColorScheme,
                        visualDensity: VisualDensity.adaptivePlatformDensity),
                  )))));
    }));
  }
}
