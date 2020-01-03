import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/lyric.dart';
import 'package:netease_cloud_music/pages/play_songs/widget_lyric.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';

class LyricPage extends StatefulWidget {
  final PlaySongsModel model;

  LyricPage(this.model);

  @override
  _LyricPageState createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> with TickerProviderStateMixin {
  LyricWidget _lyricWidget;
  LyricData _lyricData;
  List<Lyric> lyrics;
  AnimationController _lyricOffsetYController;
  int curSongId;
  Timer dragEndTimer; //拖动结束任务
  Function dragEndFunc;
  Duration dragEndDuration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((call) {
      curSongId = widget.model.curSong.id;
      _request();
    });

    dragEndFunc = () {
      if (_lyricWidget.isDragging) {
        setState(() {
          _lyricWidget.isDragging = false;
        });
      }
    };
  }

  void _request() async {
    _lyricData =
        await NetUtils.getLyricData(context, params: {'id': curSongId});
    setState(() {
      // lyrics = Utils.;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
