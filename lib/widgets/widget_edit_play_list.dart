import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';

typedef SubmitCallBack = Function(String name, String desc);

class EditPlayListWidget extends StatefulWidget {
  final SubmitCallBack submitCallBack;
  final Playlist playlist;

  EditPlayListWidget({
    @required this.submitCallBack,
    @required this.playlist,
  });

  @override
  _EditPlayListWidgetState createState() => _EditPlayListWidgetState();
}

class _EditPlayListWidgetState extends State<EditPlayListWidget> {
  bool isPrivatePlayList = false;
  TextEditingController _editingController;
  TextEditingController _descTextController;
  SubmitCallBack submitCallBack;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.playlist.name);
    _descTextController =
        TextEditingController(text: widget.playlist.description ?? "");
    _editingController.addListener(() {
      if (_editingController.text.isEmpty) {
        setState(() {
          submitCallBack = null;
        });
      } else {
        setState(() {
          if (submitCallBack == null) {
            submitCallBack = widget.submitCallBack;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '修改歌单信息',
        style: bold16TextStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20))),
      ),
      content: Theme(
        data: ThemeData(
          primaryColor: Colors.red,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _editingController,
              decoration: InputDecoration(
                hintText: '请输入歌单标题',
                hintStyle: common14GrayTextStyle,
              ),
              style: common14TextStyle,
              maxLength: 40,
            ),
            TextField(
              controller: _descTextController,
              decoration: InputDecoration(
                hintText: '请输入歌单描述',
                hintStyle: common14GrayTextStyle,
              ),
              style: common14TextStyle,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
        ),
        FlatButton(
          onPressed: () {
            submitCallBack(
              _editingController.text,
              _descTextController.text,
            );
          },
          child: Text('提交'),
          textColor: Colors.red,
        ),
      ],
    );
  }
}
