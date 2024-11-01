import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:putone/constants/height.dart';
import 'package:putone/constants/ints.dart';
import 'package:putone/constants/strings.dart';
import 'package:putone/constants/width.dart';
import 'package:putone/data/spotify_track/spotify_track.dart';
import 'package:putone/theme/app_color_theme.dart';
import 'package:putone/view/item/button/accent_color_button.dart';
import 'package:putone/view_model/auth_view_model.dart';
import 'package:putone/view_model/local_database_view_model.dart';
import 'package:putone/view_model/post_view_model.dart';

class PostAddMsgPage extends StatelessWidget {
  const PostAddMsgPage({super.key, required this.selectedTrack});

  final SpotifyTrack selectedTrack;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalObjectKey<FormState>(context);
    final AuthViewModel authViewModel = AuthViewModel();
    final PostViewModel postViewModel = PostViewModel();
    final LocalDatabaseViewModel localDatabaseViewModel =
        LocalDatabaseViewModel();

    void saveNewPost(
        GlobalObjectKey<FormState> formKey, BuildContext context) async {
      if (formKey.currentState!.validate()) {
        //msgをproviderに保存
        formKey.currentState!.save();
        //uidを取得
        authViewModel.checkUid();
        //providerにpostの情報を保存
        postViewModel.saveUid(authViewModel.uid);
        postViewModel.savePostId(returnUuidV4());
        postViewModel.savePostMusicImg(selectedTrack.trackImg);
        postViewModel.savePostMusicArtistName(selectedTrack.artistName);
        postViewModel.savePostMusicName(selectedTrack.trackName);
        postViewModel.savePostTimestamp(DateTime.now());
        postViewModel.savePostMusicSpotifyUrl(selectedTrack.trackExternalUrl);
        postViewModel.savePostMusicPreviewUrl(selectedTrack.previewUrl ?? '');
        //TODO Firestoreに入れる
        await postViewModel.uploadPost();
        print('postをfirestoreにアップロード');
        //TODO ローカルDBに入れる
        await localDatabaseViewModel.appDatabase!
            .insertLocalUserPost(postViewModel.newPost);
        //TODO postsProviderに入れる
        postViewModel.addNewPostToList();
        await Fluttertoast.showToast(msg: newPostSavedToastText);
        //元の画面まで戻る
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          postCreatePageAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: spaceWidthMedium,
            vertical: spaceHeightSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedSongLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ListTile(
                //ジャケ写
                leading: ExtendedImage.network(
                  selectedTrack.trackImg,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  cache: true,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
                //Spotify APIのSearchで取得してきた楽曲の名前を入れる。
                title: Text(selectedTrack.trackName),
                //Spotify APIのSearchで取得してきたアーティストの名前を入れる。
                subtitle: Text(selectedTrack.artistName),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 30),
              //TODO 投稿のプロバイダを作成して、プロバイダに情報を入れる
              Form(
                key: formKey,
                child: Consumer(builder: (context, ref, child) {
                  authViewModel.setRef(ref);
                  postViewModel.setRef(ref);
                  return TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      if (value.length > maxPostTextLength) {
                        return askTextLengthLessThanOrEqual120Validator;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      postViewModel.savePostMsg(value!);
                    },
                    maxLines: 6,
                    maxLength: maxPostTextLength,
                    cursorColor: AppColorTheme.color().mainColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      isDense: true,
                      hintText: postMsgHintText,
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: AppColorTheme.color().gray1,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColorTheme.color().gray1,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColorTheme.color().mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 80),
              //TODO 投稿ボタンを推した時の処理を書く
              Consumer(builder: (context, ref, _) {
                postViewModel.setRef(ref);
                localDatabaseViewModel.setRef(ref);
                return AccentColorButton(
                  onPressed: () => saveNewPost(formKey, context),
                  text: postBtnText,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
