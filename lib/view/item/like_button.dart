import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post_like/post_like.dart';
import 'package:putone/model/post_like_model.dart';
import 'package:putone/providers/user_profile_provider.dart';
import 'package:putone/theme/app_color_theme.dart';

class LikeButton extends ConsumerStatefulWidget {
  final String postId;
  final String postOwnerId;

  const LikeButton({
    Key? key,
    required this.postId,
    required this.postOwnerId,
  }) : super(key: key);

  @override
  ConsumerState<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  final PostLikeModel _postLikeModel = PostLikeModel();
  late Stream<bool> _isLikedStream;
  late Stream<int> _likeCountStream;

  @override
  void initState() {
    super.initState();
    _initLikeStreams();
  }

  void _initLikeStreams() {
    final userProfile = ref.read(userProfileProvider);
    _isLikedStream = _postLikeModel.hasUserLiked(
        widget.postId, widget.postOwnerId, userProfile.uid);
    _likeCountStream =
        _postLikeModel.getPostLikeCount(widget.postId, widget.postOwnerId);
  }

  Future<void> _toggleLike() async {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile.uid.isNotEmpty) {
      await _postLikeModel.updateLike(
        widget.postId,
        widget.postOwnerId,
        userProfile.uid,
        userProfile.userImg,
        userProfile.userName,
      );
      _initLikeStreams();
    }
  }

  void _showLikesList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<PostLike>>(
          stream:
              _postLikeModel.getPostLikeList(widget.postId, widget.postOwnerId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No likes yet',
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final like = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(like.userImg),
                  ),
                  title: Text('${like.userName}'),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _postLikeModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLikedStream,
      builder: (context, isLikedSnapshot) {
        return StreamBuilder<int>(
          stream: _likeCountStream,
          builder: (context, likeCountSnapshot) {
            final isLiked = isLikedSnapshot.data ?? false;
            final likeCount = likeCountSnapshot.data ?? 0;
            return GestureDetector(
              onTap: _toggleLike,
              onLongPress: _showLikesList,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : AppColorTheme.color().gray3,
                    size: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$likeCount likes',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColorTheme.color().gray3,
                        ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
