import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';

class UserModel with ChangeNotifier {
  User _user;

  User get user => _user;

  ///初始化user
  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(jsonDecode(s));
    }
  }

  ///登录
  void login(BuildContext context, String phone, String pwd) async {
    // User user = await NetUtils
  }
}
