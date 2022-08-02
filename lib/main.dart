import 'dart:io';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker/navigation/cubit/navigation_cubit.dart';
import 'package:money_tracker/navigation/router.dart';
import 'package:window_size/window_size.dart';
import 'firebase_options.dart';
import 'navigation/app_pages.dart';
import 'utils/color_schemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: TooltipVisibility(
        visible: false,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(colorScheme: lightColorScheme),
            darkTheme: ThemeData(colorScheme: darkColorScheme),
            home: const SplashPage()),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.splash,
      key: ValueKey(AppPages.splash),
      child: const SplashPage(),
    );
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final NavigationCubit _cubit = NavigationCubit();
  late AppRouter _router;

  // Handles all async operations then starts the actual app
  Future<Widget> futureCall() async {
    WidgetsFlutterBinding.ensureInitialized();

    //set desktop window sizing
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Money Tracker');
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
    return Future.delayed(const Duration(seconds: 6), (() {
      return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => NavigationCubit())],
          child: Router(routerDelegate: _router));
    }));
  }

  @override
  void initState() {
    _router = AppRouter(navCubit: _cubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/flutter_joke.png'),
      title: const Text(
        "MoneyTracker",
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
