import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:putone/data/user_profile/user_profile.dart';

class UserSearchModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<dynamic> searchUserByUserId(String searchUserId) async {
    try {
      final response = await firestore
          .collection('users')
          .where('userId', isEqualTo: searchUserId)
          .get();
      if (response.docs.isNotEmpty) {
        final userData = UserProfile.fromJson(response.docs.first.data());
        return userData;
      } else {
        print('$searchUserIdに該当するアカウントはありません');
        return 'no_account';
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
      return 'error';
    }
  }
}
