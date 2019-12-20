import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';

class AlbumWidget extends StatelessWidget {
  final String albumCoverUrl;
  final String albumName;
  final String albumInfo;
  const AlbumWidget(this.albumCoverUrl, this.albumName, this.albumInfo,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
      child: Row(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RoundedNetImage(
                albumCoverUrl,
                width: 140,
                height: 140,
                radius: 8,
              ),
              Image.asset(
                'images/icon_album.png',
                height: ScreenUtil().setWidth(140),
              )
            ],
          ),
          HEmptyView(10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  albumName,
                  style: common14TextStyle,
                ),
                VEmptyView(10),
                Text(
                  albumInfo,
                  style: smallGrayTextStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
