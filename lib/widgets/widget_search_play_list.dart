import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';

class SearchPlayListWidget extends StatelessWidget {
  final String url;
  final String name;
  final String info;
  final double width;
  final int id;
  final int playCount;
  const SearchPlayListWidget(
      {this.id,
      this.url,
      this.name,
      this.info,
      this.width = 140,
      this.playCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.goPlayListPage(context,
            data: Recommend(
              id: id,
              name: name,
              picUrl: url,
              playcount: playCount,
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Row(
          children: <Widget>[
            RoundedNetImage(
              url,
              width: width,
              height: width,
              radius: 8,
            ),
            HEmptyView(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: common14TextStyle,
                  ),
                  VEmptyView(10),
                  Text(
                    info,
                    style: smallGrayTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}