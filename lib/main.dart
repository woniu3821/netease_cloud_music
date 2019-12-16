import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/pages/splash_page.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/route/navigate_service.dart';
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/utils/log_util.dart';
import 'package:provider/provider.dart';

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  Application.setupLocator();
  LogUtil.init(tag: 'NETEASE_MUSIC');

  Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
      ),
      ChangeNotifierProvider<PlaySongsModel>(
        create: (_) => PlaySongsModel()..init(),
      ),
      ChangeNotifierProvider<PlayListModel>(
        create: (_) => PlayListModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: Application.getIt<NavigateService>().key,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        splashColor: Colors.transparent,
        tooltipTheme: TooltipThemeData(verticalOffset: -100000),
      ),
      home: SplashPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
