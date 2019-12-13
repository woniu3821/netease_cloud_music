import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/route/route_handles.dart';

class Routes {
  static String root = "/";
  static String home = '/home';
  static String login = "/login";
  static String dailySongs = '/daily_songs';
  static String search = "/search";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return null;
    });

    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(search, handler: searchHandler);
  }
}
