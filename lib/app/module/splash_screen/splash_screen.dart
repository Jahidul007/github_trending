import 'dart:async';
import 'package:flutter/material.dart';
import 'package:github_trending/app/utils/constants.dart';
import 'package:github_trending/route/github_trending_app_route.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CompositeSubscription subscription = CompositeSubscription();

  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    nextRoute();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Theme.of(context).primaryColor,
            child: Image.asset(
              'assets/images/ic_github_logo.png',
            ),
          ),
        ),
      ),
    );
  }

  nextRoute() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(_context!, GithubAppRoute.homeScreen,
          arguments: null);
    });
  }

  @override
  void dispose() {
    subscription.dispose();
    super.dispose();
  }
}
