// lib/view/module_page/post_card.dart
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post/post.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/model/post_answer_model.dart';
import 'package:putone/view/item/answer_list.dart';
import 'package:putone/view/item/answer_pie_chart.dart';
import 'package:extended_image/extended_image.dart';

class PostCard extends ConsumerStatefulWidget {
  final Post post;
  final String uid;
  final String userImg;
  final String userName;

  const PostCard(
      {Key? key,
      required this.post,
      required this.uid,
      required this.userImg,
      required this.userName})
      : super(key: key);

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool _isExpanded = false;
  double _cachedPercentage = 0.0;
  bool _isLoading = true;
  final postAnswerModel = PostAnswerModel();

  // stream subscriptionで明示的にdisposeする
  StreamSubscription? _percentageSubscription;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Stream<void> _loadInitialData() {
    final stream = postAnswerModel.calculateCorrectAnswerPercentageStream(
        widget.uid, widget.post.postId);

    _percentageSubscription = stream.listen((percentage) {
      if (mounted) {
        setState(() {
          _cachedPercentage = percentage;
          _isLoading = false;
        });
      }
    }, onError: (error) {
      print('Percentage stream error: $error');
    }, cancelOnError: false);
    return stream;
  }

  @override
  void dispose() {
    _percentageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: ExtendedImage.network(
                      widget.post.postMusicImg,
                      cache: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post.postMusicName,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    widget.post.postMusicArtistName,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            if (_isLoading)
                              CircularProgressIndicator(strokeWidth: 2)
                            else
                              Text(
                                '${_cachedPercentage.toStringAsFixed(0)}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 16),
                StreamBuilder<List<PostAnswer>>(
                  stream: postAnswerModel.getPostAnswersStream(
                      widget.uid, widget.post.postId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('回答の取得に失敗しました: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('まだ回答がありません');
                    }

                    final answers = snapshot.data!;
                    return Column(
                      children: [
                        StreamBuilder<double>(
                          stream: postAnswerModel
                              .calculateCorrectAnswerPercentageStream(
                                  widget.uid, widget.post.postId),
                          builder: (context, percentageSnapshot) {
                            if (percentageSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (percentageSnapshot.hasError) {
                              return Text('正答率の取得に失敗しました');
                            }

                            final percentage = percentageSnapshot.data ?? 0.0;
                            return AnswerPieChart(percentage: percentage);
                          },
                        ),
                        SizedBox(height: 16),
                        AnswersList(
                            answers: answers,
                            correctUid: widget.uid,
                            correctUserImg: widget.userImg,
                            correctUserName: widget.userName),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}