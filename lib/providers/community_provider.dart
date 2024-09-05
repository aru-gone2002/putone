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
      'meidai': const Community(
        communityId: 'meidai',
        communityName: '名古屋大学',
      ),
      'hokudai': const Community(
        communityId: 'hokudai',
        communityName: '北海道大学',
      ),
      '100pro': const Community(
        communityId: '100pro',
        communityName: '100 Program',
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
