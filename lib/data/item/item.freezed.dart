// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get uid => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  bool get isForSale => throw _privateConstructorUsedError;
  String get artistSpotifyId => throw _privateConstructorUsedError;
  String get artistName => throw _privateConstructorUsedError;
  String get artistSpotifyUrl => throw _privateConstructorUsedError;
  List<String> get itemImgs => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;
  String get itemDiscription => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String uid,
      String itemId,
      bool isForSale,
      String artistSpotifyId,
      String artistName,
      String artistSpotifyUrl,
      List<String> itemImgs,
      String itemName,
      String itemDiscription,
      double price,
      String size,
      List<String> categories,
      DateTime createdAt});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? itemId = null,
    Object? isForSale = null,
    Object? artistSpotifyId = null,
    Object? artistName = null,
    Object? artistSpotifyUrl = null,
    Object? itemImgs = null,
    Object? itemName = null,
    Object? itemDiscription = null,
    Object? price = null,
    Object? size = null,
    Object? categories = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      isForSale: null == isForSale
          ? _value.isForSale
          : isForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      artistSpotifyId: null == artistSpotifyId
          ? _value.artistSpotifyId
          : artistSpotifyId // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      artistSpotifyUrl: null == artistSpotifyUrl
          ? _value.artistSpotifyUrl
          : artistSpotifyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      itemImgs: null == itemImgs
          ? _value.itemImgs
          : itemImgs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      itemDiscription: null == itemDiscription
          ? _value.itemDiscription
          : itemDiscription // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String itemId,
      bool isForSale,
      String artistSpotifyId,
      String artistName,
      String artistSpotifyUrl,
      List<String> itemImgs,
      String itemName,
      String itemDiscription,
      double price,
      String size,
      List<String> categories,
      DateTime createdAt});
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? itemId = null,
    Object? isForSale = null,
    Object? artistSpotifyId = null,
    Object? artistName = null,
    Object? artistSpotifyUrl = null,
    Object? itemImgs = null,
    Object? itemName = null,
    Object? itemDiscription = null,
    Object? price = null,
    Object? size = null,
    Object? categories = null,
    Object? createdAt = null,
  }) {
    return _then(_$ItemImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      isForSale: null == isForSale
          ? _value.isForSale
          : isForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      artistSpotifyId: null == artistSpotifyId
          ? _value.artistSpotifyId
          : artistSpotifyId // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      artistSpotifyUrl: null == artistSpotifyUrl
          ? _value.artistSpotifyUrl
          : artistSpotifyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      itemImgs: null == itemImgs
          ? _value._itemImgs
          : itemImgs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      itemDiscription: null == itemDiscription
          ? _value.itemDiscription
          : itemDiscription // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl with DiagnosticableTreeMixin implements _Item {
  const _$ItemImpl(
      {required this.uid,
      required this.itemId,
      required this.isForSale,
      required this.artistSpotifyId,
      required this.artistName,
      required this.artistSpotifyUrl,
      required final List<String> itemImgs,
      required this.itemName,
      required this.itemDiscription,
      required this.price,
      required this.size,
      required final List<String> categories,
      required this.createdAt})
      : _itemImgs = itemImgs,
        _categories = categories;

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  final String uid;
  @override
  final String itemId;
  @override
  final bool isForSale;
  @override
  final String artistSpotifyId;
  @override
  final String artistName;
  @override
  final String artistSpotifyUrl;
  final List<String> _itemImgs;
  @override
  List<String> get itemImgs {
    if (_itemImgs is EqualUnmodifiableListView) return _itemImgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemImgs);
  }

  @override
  final String itemName;
  @override
  final String itemDiscription;
  @override
  final double price;
  @override
  final String size;
  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Item(uid: $uid, itemId: $itemId, isForSale: $isForSale, artistSpotifyId: $artistSpotifyId, artistName: $artistName, artistSpotifyUrl: $artistSpotifyUrl, itemImgs: $itemImgs, itemName: $itemName, itemDiscription: $itemDiscription, price: $price, size: $size, categories: $categories, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Item'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('itemId', itemId))
      ..add(DiagnosticsProperty('isForSale', isForSale))
      ..add(DiagnosticsProperty('artistSpotifyId', artistSpotifyId))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('artistSpotifyUrl', artistSpotifyUrl))
      ..add(DiagnosticsProperty('itemImgs', itemImgs))
      ..add(DiagnosticsProperty('itemName', itemName))
      ..add(DiagnosticsProperty('itemDiscription', itemDiscription))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.isForSale, isForSale) ||
                other.isForSale == isForSale) &&
            (identical(other.artistSpotifyId, artistSpotifyId) ||
                other.artistSpotifyId == artistSpotifyId) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.artistSpotifyUrl, artistSpotifyUrl) ||
                other.artistSpotifyUrl == artistSpotifyUrl) &&
            const DeepCollectionEquality().equals(other._itemImgs, _itemImgs) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.itemDiscription, itemDiscription) ||
                other.itemDiscription == itemDiscription) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      itemId,
      isForSale,
      artistSpotifyId,
      artistName,
      artistSpotifyUrl,
      const DeepCollectionEquality().hash(_itemImgs),
      itemName,
      itemDiscription,
      price,
      size,
      const DeepCollectionEquality().hash(_categories),
      createdAt);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String uid,
      required final String itemId,
      required final bool isForSale,
      required final String artistSpotifyId,
      required final String artistName,
      required final String artistSpotifyUrl,
      required final List<String> itemImgs,
      required final String itemName,
      required final String itemDiscription,
      required final double price,
      required final String size,
      required final List<String> categories,
      required final DateTime createdAt}) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  String get uid;
  @override
  String get itemId;
  @override
  bool get isForSale;
  @override
  String get artistSpotifyId;
  @override
  String get artistName;
  @override
  String get artistSpotifyUrl;
  @override
  List<String> get itemImgs;
  @override
  String get itemName;
  @override
  String get itemDiscription;
  @override
  double get price;
  @override
  String get size;
  @override
  List<String> get categories;
  @override
  DateTime get createdAt;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
