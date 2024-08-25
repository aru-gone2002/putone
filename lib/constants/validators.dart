import 'package:flutter/material.dart';
import 'package:putone/constants/strings.dart';

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return notInputEmailText;
  }
  if (!RegExp(
    caseSensitive: false,
    r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
    //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(value)) {
    return inputEmailIsNotValidText;
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return notInputPasswordText;
  }
  if (!RegExp(r'^[a-zA-Z0-9\W]{8,}$')
      // r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
      .hasMatch(value)) {
    return inputPasswordIsNotValidText;
  }
  return null;
}

String? userIdValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return notInputUserIdText;
  }
  //小文字と.と数字で入力してもらうようにする。正規表現のやつ
  //TODO 文字数制限をつける
  if (!RegExp(r'^[a-z0-9.]{4,16}$').hasMatch(value)) {
    return inputUserIdIsNotValidText;
  }
  return null;
}

String? userNameValidator(String? value) {
  //TODO 文字数制限をつける
  if (value == null || value.trim().isEmpty) {
    return notInputUserNameText;
  }
  if (!RegExp(r'^.{1,16}').hasMatch(value)) {
    return inputUserIdIsNotValidText;
  }
  return null;
}
