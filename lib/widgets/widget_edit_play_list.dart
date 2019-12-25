import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/play_list.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
