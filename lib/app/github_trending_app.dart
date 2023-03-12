import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_trending/app/utils/constants.dart';
import 'package:github_trending/route/route_generator.dart';

class GithubTrendingApp extends StatefulWidget {
  const GithubTrendingApp({Key? key}) : super(key: key);

  @override
  _GithubTrendingAppState createState() => _GithubTrendingAppState();
}

class _GithubTrendingAppState extends State<GithubTrendingApp> {
  late final StreamSubscription onMessageSubscription;
  late final StreamSubscription onMessageOpenedSubscription;

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;



  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setOrientation();
  }






  _setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() async {
    super.dispose();

    await onMessageSubscription.cancel();
    await onMessageOpenedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Wallet',

      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: const Color(0xff171515),
        textTheme: const TextTheme(),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xff171515, primaryColorMap),
        ).copyWith(secondary: primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
