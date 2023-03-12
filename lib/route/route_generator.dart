
import 'package:flutter/material.dart';
import 'package:github_trending/route/github_trending_app_route.dart';


class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {

    MaterialPageRoute? page;

    page = getGithubTrendingAppRoutes(settings);
    if (page != null) return page;


    return page; //todo this might cause error
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
