// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      uid: json['uid'] as String,
      itemId: json['itemId'] as String,
      isForSale: json['isForSale'] as bool,
      artistSpotifyId: json['artistSpotifyId'] as String,
      artistName: json['artistName'] as String,
      artistSpotifyUrl: json['artistSpotifyUrl'] as String,
      itemImgs:
          (json['itemImgs'] as List<dynamic>).map((e) => e as String).toList(),
      itemName: json['itemName'] as String,
      itemDescription: json['itemDescription'] as String,
      price: (json['price'] as num).toInt(),
      size: json['size'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'itemId': instance.itemId,
      'isForSale': instance.isForSale,
      'artistSpotifyId': instance.artistSpotifyId,
      'artistName': instance.artistName,
      'artistSpotifyUrl': instance.artistSpotifyUrl,
      'itemImgs': instance.itemImgs,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'price': instance.price,
      'size': instance.size,
      'categories': instance.categories,
      'createdAt': instance.createdAt.toIso8601String(),
    };
