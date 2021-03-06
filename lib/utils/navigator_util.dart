import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/pages/look_img_page.dart';
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/route/transparent_route.dart';
import 'package:netease_cloud_music/utils/fluro_convert_utils.dart';

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

  // 播放歌曲页面
  static void goPlaySongsPage(BuildContext context) {
    _navigateTo(context, Routes.playSongs);
  }

  //歌单详情
  static void goPlayListPage(BuildContext context, {@required Recommend data}) {
    _navigateTo(context,
        "${Routes.playList}?data=${FluroConvertUtils.object2string(data)}");
  }

  // 排行榜首页
  static void goTopListPage(BuildContext context) {
    _navigateTo(context, Routes.topList);
  }

  //搜索页面
  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }

  //评论页面
  static void goCommentPage(BuildContext context,
      {@required CommentHead data}) {
    _navigateTo(context,
        '${Routes.comment}?data=${FluroConvertUtils.object2string(data)}');
  }

  //查看图片页面
  static void goLookImgPage(
      BuildContext context, List<String> imgs, int index) {
    Navigator.push(
      context,
      TransparentRoute(
        builder: (_) => LookImgPage(imgs, index),
      ),
    );
  }
}
