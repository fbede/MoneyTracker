import 'dart:io';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/navigation/routes.dart';
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
    /*Used to automatically hide keyboard when filling forms all around the app*/
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: TooltipVisibility(
        visible: false,
        //This is the actual app
        child: MaterialApp(
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
        ),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/flutter_joke.png'),
      title: Text(
        appName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: futureCall(),
    );
  }

  // Handles all async operations then starts the actual app
  Future<Widget> futureCall() async {
    WidgetsFlutterBinding.ensureInitialized();

    //set desktop window sizing
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

    //start actual app
    final GoRouter router = GoRouter(routes: appRoutes);
    return Future.delayed(const Duration(seconds: 6), (() {
      return MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        //repeated here, descendant widgets use this
        title: appName,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            colorScheme: lightColorScheme,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            visualDensity: VisualDensity.adaptivePlatformDensity),
      );
    }));
  }
}
