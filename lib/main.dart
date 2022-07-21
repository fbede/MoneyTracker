// ignore: depend_on_referenced_packages
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'utils/color_schemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: lightColorScheme),
        darkTheme: ThemeData(colorScheme: darkColorScheme),
        home: const SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Handles all async operations then starts the actual app
  Future<Widget> futureCall() async {
    WidgetsFlutterBinding.ensureInitialized();

    //Initialize firebase
    if ((defaultTargetPlatform == TargetPlatform.windows) ||
        (defaultTargetPlatform == TargetPlatform.linux)) {
      const firebaseOptions = FirebaseOptions(
        appId: String.fromEnvironment('FIREBASE_APP_ID'),
        apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
        projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
        messagingSenderId: String.fromEnvironment('FIREBASE_SENDER_ID'),
        authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      );
      await Firebase.initializeApp(options: firebaseOptions);
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    //start actual app
    return Future.value(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/flutter_joke.png'),
      title: const Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: futureCall(),
    );
  }
}
