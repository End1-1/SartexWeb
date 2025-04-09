// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_partner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return _Partner.fromJson(json);
}

/// @nodoc
mixin _$Partner {
  String get id => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this Partner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerCopyWith<Partner> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) then) =
      _$PartnerCopyWithImpl<$Res, Partner>;
  @useResult
  $Res call(
      {String id, String branch, String country, String name, String type});
}

/// @nodoc
class _$PartnerCopyWithImpl<$Res, $Val extends Partner>
    implements $PartnerCopyWith<$Res> {
  _$PartnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? country = null,
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerImplCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$$PartnerImplCopyWith(
          _$PartnerImpl value, $Res Function(_$PartnerImpl) then) =
      __$$PartnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String branch, String country, String name, String type});
}

/// @nodoc
class __$$PartnerImplCopyWithImpl<$Res>
    extends _$PartnerCopyWithImpl<$Res, _$PartnerImpl>
    implements _$$PartnerImplCopyWith<$Res> {
  __$$PartnerImplCopyWithImpl(
      _$PartnerImpl _value, $Res Function(_$PartnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? country = null,
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$PartnerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerImpl implements _Partner {
  const _$PartnerImpl(
      {required this.id,
      required this.branch,
      required this.country,
      required this.name,
      required this.type});

  factory _$PartnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerImplFromJson(json);

  @override
  final String id;
  @override
  final String branch;
  @override
  final String country;
  @override
  final String name;
  @override
  final String type;

  @override
  String toString() {
    return 'Partner(id: $id, branch: $branch, country: $country, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, branch, country, name, type);

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerImplCopyWith<_$PartnerImpl> get copyWith =>
      __$$PartnerImplCopyWithImpl<_$PartnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerImplToJson(
      this,
    );
  }
}

abstract class _Partner implements Partner {
  const factory _Partner(
      {required final String id,
      required final String branch,
      required final String country,
      required final String name,
      required final String type}) = _$PartnerImpl;

  factory _Partner.fromJson(Map<String, dynamic> json) = _$PartnerImpl.fromJson;

  @override
  String get id;
  @override
  String get branch;
  @override
  String get country;
  @override
  String get name;
  @override
  String get type;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerImplCopyWith<_$PartnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartnerList _$PartnerListFromJson(Map<String, dynamic> json) {
  return _PartnerList.fromJson(json);
}

/// @nodoc
mixin _$PartnerList {
  List<Partner> get partners => throw _privateConstructorUsedError;

  /// Serializes this PartnerList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerListCopyWith<PartnerList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerListCopyWith<$Res> {
  factory $PartnerListCopyWith(
          PartnerList value, $Res Function(PartnerList) then) =
      _$PartnerListCopyWithImpl<$Res, PartnerList>;
  @useResult
  $Res call({List<Partner> partners});
}

/// @nodoc
class _$PartnerListCopyWithImpl<$Res, $Val extends PartnerList>
    implements $PartnerListCopyWith<$Res> {
  _$PartnerListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partners = null,
  }) {
    return _then(_value.copyWith(
      partners: null == partners
          ? _value.partners
          : partners // ignore: cast_nullable_to_non_nullable
              as List<Partner>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerListImplCopyWith<$Res>
    implements $PartnerListCopyWith<$Res> {
  factory _$$PartnerListImplCopyWith(
          _$PartnerListImpl value, $Res Function(_$PartnerListImpl) then) =
      __$$PartnerListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Partner> partners});
}

/// @nodoc
class __$$PartnerListImplCopyWithImpl<$Res>
    extends _$PartnerListCopyWithImpl<$Res, _$PartnerListImpl>
    implements _$$PartnerListImplCopyWith<$Res> {
  __$$PartnerListImplCopyWithImpl(
      _$PartnerListImpl _value, $Res Function(_$PartnerListImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partners = null,
  }) {
    return _then(_$PartnerListImpl(
      partners: null == partners
          ? _value._partners
          : partners // ignore: cast_nullable_to_non_nullable
              as List<Partner>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerListImpl implements _PartnerList {
  const _$PartnerListImpl({required final List<Partner> partners})
      : _partners = partners;

  factory _$PartnerListImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerListImplFromJson(json);

  final List<Partner> _partners;
  @override
  List<Partner> get partners {
    if (_partners is EqualUnmodifiableListView) return _partners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partners);
  }

  @override
  String toString() {
    return 'PartnerList(partners: $partners)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerListImpl &&
            const DeepCollectionEquality().equals(other._partners, _partners));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_partners));

  /// Create a copy of PartnerList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerListImplCopyWith<_$PartnerListImpl> get copyWith =>
      __$$PartnerListImplCopyWithImpl<_$PartnerListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerListImplToJson(
      this,
    );
  }
}

abstract class _PartnerList implements PartnerList {
  const factory _PartnerList({required final List<Partner> partners}) =
      _$PartnerListImpl;

  factory _PartnerList.fromJson(Map<String, dynamic> json) =
      _$PartnerListImpl.fromJson;

  @override
  List<Partner> get partners;

  /// Create a copy of PartnerList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerListImplCopyWith<_$PartnerListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
