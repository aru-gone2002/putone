// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'user_auth.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'user_auth.g.dart';

@freezed
class UserAuth with _$UserAuth {
  const factory UserAuth({
    required String uid,
    required String userEmail,
    required String userPassword,
    required bool userEmailVerified,
  }) = _UserAuth;

  factory UserAuth.fromJson(Map<String, Object?> json) =>
      _$UserAuthFromJson(json);
}
