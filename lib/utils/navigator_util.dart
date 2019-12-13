import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/route/routes.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionsBuilder}) {
    Application.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionsBuilder,
      transition: TransitionType.material,
    );
  }

  //登录页
  static void goLoginPage(BuildContext context) {
    _navigateTo(
      context,
      Routes.login,
      clearStack: true,
    );
  }

  //首页
  static void goHomePage(BuildContext context) {
    _navigateTo(
      context,
      Routes.home,
      clearStack: true,
    );
  }

  //每日推荐歌曲
  static void goDailySongsPage(BuildContext context) {
    _navigateTo(context, Routes.dailySongs);
  }

  //搜索页面
  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }
}
