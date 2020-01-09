import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/song_comment.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';

class CommentPage extends StatefulWidget {
  final CommentHead commentHead;

  CommentPage(this.commentHead);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Map<String, int> params;
  List<Comments> commentData = [];
  EasyRefreshController _controller;
  FocusNode _blankNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      params = {'id': widget.commentHead.id};
      _request();
    });
  }

  void _request() async {
    var r = await NetUtils.getCommentData(context, widget.commentHead.type,
        params: params);
    setState(() {
      if (r.hotComments != null && r.hotComments.isNotEmpty) {
        commentData.add(Comments(isTitle: true, title: "精彩评论"));
        commentData.addAll(r.hotComments);
      }

      if (commentData.where((d) => d.title == "最新评论").isEmpty) {
        commentData.add(Comments(isTitle: true, title: "最新评论"));
      }

      commentData.addAll(r.comments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('评论(${widget.commentHead.count})'),
      ),
      body: Stack(
        children: <Widget>[
          Listener(
            onPointerDown: (d) {
              FocusScope.of(context).requestFocus(_blankNode);
            },
            //TODO
          ),
        ],
      ),
    );
  }
}
