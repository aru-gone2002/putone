import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/post_answer/post_answer.dart';
import 'package:putone/model/post_answer_model.dart';

final postAnswerModelProvider = Provider((ref) => PostAnswerModel());

final postAnswersProvider =
    FutureProvider.family<List<PostAnswer>, Map<String, String>>(
  (ref, params) async {
    try {
      final model = ref.watch(postAnswerModelProvider);
      final answers =
          await model.getPostAnswers(params['uid']!, params['postId']!);
      print("Answers fetched successfully: ${answers.length}"); // デバッグ出力
      return answers;
    } catch (e, stackTrace) {
      print("Error in postAnswersProvider: $e");
      print("Stack trace: $stackTrace");
      throw e; // エラーを再スローして、UIでキャッチできるようにします
    }
  },
);

final correctAnswerPercentageProvider =
    FutureProvider.family<double, Map<String, String>>((ref, params) async {
  final model = ref.watch(postAnswerModelProvider);
  return await model.calculateCorrectAnswerPercentage(
      params['uid']!, params['postId']!);
});
