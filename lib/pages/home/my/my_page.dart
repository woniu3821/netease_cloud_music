import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  Map<String, String> topMenudata = {
    '本地音乐': 'images/icon_music.png',
    '最近播放': 'images/icon_late_play.png',
    '下载管理': 'images/icon_download_black.png',
    '我的电台': 'images/icon_broadcast.png',
    '我的收藏': 'images/icon_collect.png',
  };

  List<String> topMenuKeys;
  bool selfPlayListOffstage = false;
  bool collectPlayListOffstage = false;
  PlayListModel _playListModel;

  @override
  void initState() {
    super.initState();
    topMenuKeys = topMenudata.keys.toList();

    WidgetsBinding.instance.addPostFrameCallback((d) {
      //在一帧的最后调用，并且只调用一次
      if (mounted) {
        _playListModel = Provider.of<PlayListModel>(context);
        _playListModel.getSelfPlaylistData(context);
      }
    });
  }

  Widget _buildTopMenu() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curKey = topMenuKeys[index];
        var curValue = topMenudata[curKey];
        return Container(
          height: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(140),
                child: Align(
                  child: Image.asset(
                    curValue,
                    width: ScreenUtil().setWidth(100),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  curKey,
                  style: commonTextStyle,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
          height: ScreenUtil().setWidth(0.3),
        );
      },
    );
  }

  // 构建「我创建的歌单」「收藏的歌单」
  Widget _buildPlayListItem(List<Playlist> data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curPlayList = data[index];
        return ListTile(
          onTap: () {
            NavigatorUtil.goPlayListPage(context,
                data: Recommend(
                  picUrl: curPlayList.coverImgUrl,
                  name: curPlayList.name,
                  playcount: curPlayList.playCount,
                  id: curPlayList.id,
                ));
          },
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(5),
            ),
            child: Text(curPlayList.name),
          ),
          subtitle: Text(
            '${curPlayList.trackCount}首',
            style: smallGrayTextStyle,
          ),
          leading: RoundedNetImage(
            curPlayList.coverImgUrl,
            width: 110,
            height: 110,
            radius: ScreenUtil().setWidth(12),
          ),
          trailing: SizedBox(
            height: ScreenUtil().setWidth(50),
            width: ScreenUtil().setWidth(70),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.grey,
              onPressed: () {
                showModalBottomSheet<Playlist>(
                    context: context,
                    builder: (context) {
                      return PlayList;
                    });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
