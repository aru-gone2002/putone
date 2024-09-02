import 'package:flutter/material.dart';
import 'package:putone/model/post_user_model.dart';
import 'package:putone/theme/app_color_theme.dart';

class PostUserInfo extends StatefulWidget {
  final String uid;
  final DateTime postTimestamp;

  const PostUserInfo({Key? key, required this.uid, required this.postTimestamp})
      : super(key: key);

  @override
  _PostUserInfoState createState() => _PostUserInfoState();
}

class _PostUserInfoState extends State<PostUserInfo> {
  final PostUserModel _postUserModel = PostUserModel();
  Map<String, dynamic>? _userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final userInfo = await _postUserModel.getUserInfo(widget.uid);
    if (mounted) {
      setState(() {
        _userInfo = userInfo;
      });
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(widget.postTimestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                _userInfo != null ? NetworkImage(_userInfo!['userImg']) : null,
            radius: 18,
          ),
          SizedBox(width: 10),
          Text(
            _userInfo != null ? _userInfo!['userName'] : 'Loading...',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColorTheme.color().gray3,
                ),
          ),
          SizedBox(width: 10),
          Text(
            _getTimeAgo(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColorTheme.color().gray3.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}
