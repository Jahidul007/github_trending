import 'package:flutter/material.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_repository/top_repository_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/top_user_response.dart';
import 'package:github_trending/app/module/home_screen/screen/details/top_repository_details_screen.dart';
import 'package:github_trending/app/module/home_screen/screen/details/top_user_details_screen.dart';
import 'package:github_trending/app/module/home_screen/screen/home_screen.dart';
import 'package:github_trending/app/module/splash_screen/splash_screen.dart';

abstract class GithubAppRoute {
  static const String splash = "/splash";

  static const String homeScreen = '/homeScreen';
  static const String topRepositoryDetailsScreen =
      '/topRepositoryDetailsScreen';
  static const String topUserDetailsScreen =
      '/topUserDetailsScreen';
}

MaterialPageRoute? getGithubTrendingAppRoutes(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        settings: const RouteSettings(name: GithubAppRoute.splash),
        builder: (_) => const SplashScreen(),
      );

    case GithubAppRoute.homeScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: GithubAppRoute.homeScreen),
        builder: (_) => const HomeScreen(),
      );

    case GithubAppRoute.topRepositoryDetailsScreen:
      ItemRepository? items;
      if (args is ItemRepository) {
        items = args;
      }
      return MaterialPageRoute(
        settings: const RouteSettings(
            name: GithubAppRoute.topRepositoryDetailsScreen),
        builder: (_) => TopRepositoryDetailsScreen(items: items!),
      );
    case GithubAppRoute.topUserDetailsScreen:
      Items? items;
      if (args is Items) {
        items = args;
      }
      return MaterialPageRoute(
        settings: const RouteSettings(
            name: GithubAppRoute.topUserDetailsScreen),
        builder: (_) => TopUserDetailsScreen(items: items!),
      );

    default:
      return null;
  }
}
