import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';

typedef SubmitCallBack = Function(String name, bool isPrivate);

class CreatePlayListWidget extends StatefulWidget {
  final SubmitCallBack submitCallBack;

  CreatePlayListWidget({@required this.submitCallBack});

  @override
  _CreatePlayListWidgetState createState() => _CreatePlayListWidgetState();
}

class _CreatePlayListWidgetState extends State<CreatePlayListWidget> {
  bool isPrivatePlayList = false;
  TextEditingController _editingController;
  SubmitCallBack submitCallBack;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
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
        '新建歌单',
        style: bold16TextStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20))),
      ),
      content: Theme(
        data: ThemeData(primaryColor: Colors.red),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _editingController,
              decoration: InputDecoration(
                hintText: "输入歌单标题",
                hintStyle: common14GrayTextStyle,
              ),
              style: common14TextStyle,
              maxLength: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isPrivatePlayList = !isPrivatePlayList;
                });
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                    child: Checkbox(
                      activeColor: Colors.red,
                      value: isPrivatePlayList,
                      onChanged: (v) {
                        setState(() {
                          isPrivatePlayList = v;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  HEmptyView(4),
                  Text(
                    '设置为隐私歌单',
                    style: common15GrayTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          textColor: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('提交'),
          textColor: Colors.red,
          onPressed: submitCallBack == null
              ? null
              : () {
                  submitCallBack(_editingController.text, isPrivatePlayList);
                },
        ),
      ],
    );
  }
}
