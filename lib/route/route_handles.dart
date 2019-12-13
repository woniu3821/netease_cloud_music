//splash 页面

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/home/home_page.dart';
import 'package:netease_cloud_music/pages/login_page.dart';
import 'package:netease_cloud_music/pages/splash_page.dart';

//首屏splash
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

//登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});

//主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return HomePage();
});

// 跳转到搜索页面

var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Text('搜索页 SearchPage');
});
