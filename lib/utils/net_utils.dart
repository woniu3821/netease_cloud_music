import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/banner.dart' as mBanner;
import 'package:netease_cloud_music/model/daily_songs.dart';
import 'package:netease_cloud_music/model/event.dart' as prefix0;
import 'package:netease_cloud_music/model/hot_search.dart';
import 'package:netease_cloud_music/model/mv.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/search_result.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/route/navigate_service.dart';
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/utils/custom_log_interceptor.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/loading.dart';
import 'package:path_provider/path_provider.dart';

class NetUtils {
  static Dio _dio;
  static final String baseUrl = 'http://127.0.0.1';

  static void init() async {
    //获取沙盒路径，用于存储cookie
    Directory temDir = await getTemporaryDirectory();
    String tempPath = temDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio(BaseOptions(baseUrl: '$baseUrl:3000', followRedirects: false))
      ..interceptors.add(CookieManager(cj))
      ..interceptors.add(
        CustomLogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
  }

  static Future<Response> _get(
    BuildContext context,
    String url, {
    Map<String, dynamic> params,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) Loading.showLoading(context);
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
          _reLogin();
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static void _reLogin() {
    Future.delayed(Duration(microseconds: 200), () {
      Application.getIt<NavigateService>().popAndPushNamed(Routes.login);
      Utils.showToatst('登录失效，请重新登录');
    });
  }

  ///登录
  static Future<User> login(
      BuildContext context, String phone, String password) async {
    var response = await _get(context, '/login/cellphone',
        params: {'phone': phone, 'password': password});

    return User.fromJson(response.data);
  }

  static Future<Response> refreshLogin(BuildContext context) async {
    return await _get(
      context,
      '/login/refresh',
      isShowLoading: false,
    ).catchError((e) {
      Utils.showToatst('网络错误！');
    });
  }

  //首页banner
  static Future<mBanner.Banner> getBannerData(BuildContext context) async {
    var response = await _get(context, '/banner', params: {'type': 1});
    return mBanner.Banner.fromJson(response.data);
  }

  //推荐歌单
  static Future<RecommendData> getRecommendData(BuildContext context) async {
    var response = await _get(context, '/recommend/resource');
    return RecommendData.fromJson(response.data);
  }

  //新碟上架
  static Future<AlbumData> getAlbumData(
    BuildContext context, {
    Map<String, dynamic> params = const {'offset': 0, 'limit': 10},
  }) async {
    var response = await _get(context, '/top/album', params: params);
    return AlbumData.fromJson(response.data);
  }

  //MV排行
  static Future<MVData> getTopMvData(
    BuildContext context, {
    Map<String, dynamic> params = const {'offset': 0, 'limit': 10},
  }) async {
    var response = await _get(context, '/top/mv', params: params);
    return MVData.fromJson(response.data);
  }

  //每日推荐歌曲
  static Future<DailySongsData> getDailySongData(BuildContext context) async {
    var response = await _get(
      context,
      '/recommend/songs',
    );
    return DailySongsData.fromJson(response.data);
  }

  /// 获取个人歌单
  static Future<MyPlayListData> getSelfPlaylistData(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    var response = await _get(
      context,
      '/user/playlist',
      params: params,
      isShowLoading: false,
    );

    return MyPlayListData.fromJson(response.data);
  }

  // 获取动态数据
  static Future<prefix0.EventData> getEventData(
      {@required Map<String, dynamic> params}) async {
    var response =
        await _get(null, '/event', params: params, isShowLoading: false);
    return prefix0.EventData.fromJson(response.data);
  }

  // 获取热门搜索数据
  static Future<HotSearchData> getHotSearchData(BuildContext context) async {
    var response =
        await _get(context, '/search/hot/detail', isShowLoading: false);
    return HotSearchData.fromJson(response);
  }

  // 综合搜索
  static Future<SearchMultipleData> searchMultiple(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    var response =
        await _get(context, '/search', params: params, isShowLoading: false);

    return SearchMultipleData.fromJson(response.data);
  }
}
