import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:putone/data/community/community.dart';

final communityMapProvider = StateProvider<Map<String, Community>>((ref) => {
      'rikadai': const Community(
        communityId: 'rikadai',
        communityName: '東京理科大学',
      ),
      'musashino': const Community(
        communityId: 'musashino',
        communityName: '武蔵野大学',
      ),
      'toudai': const Community(
        communityId: 'toudai',
        communityName: '東京大学',
      ),
      'none': const Community(
        communityId: 'none',
        communityName: '未設定',
      ),
    });

final selectedCommunityProvider = StateProvider<Community>(
  (ref) => const Community(
    communityId: 'none',
    communityName: '未設定',
  ),
);
