//splash 页面

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/splash_page.dart';

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});
