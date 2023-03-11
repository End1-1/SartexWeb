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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_PartnerCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$$_PartnerCopyWith(
          _$_Partner value, $Res Function(_$_Partner) then) =
      __$$_PartnerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String branch, String country, String name, String type});
}

/// @nodoc
class __$$_PartnerCopyWithImpl<$Res>
    extends _$PartnerCopyWithImpl<$Res, _$_Partner>
    implements _$$_PartnerCopyWith<$Res> {
  __$$_PartnerCopyWithImpl(_$_Partner _value, $Res Function(_$_Partner) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? country = null,
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$_Partner(
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
class _$_Partner implements _Partner {
  const _$_Partner(
      {required this.id,
      required this.branch,
      required this.country,
      required this.name,
      required this.type});

  factory _$_Partner.fromJson(Map<String, dynamic> json) =>
      _$$_PartnerFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Partner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, branch, country, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PartnerCopyWith<_$_Partner> get copyWith =>
      __$$_PartnerCopyWithImpl<_$_Partner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PartnerToJson(
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
      required final String type}) = _$_Partner;

  factory _Partner.fromJson(Map<String, dynamic> json) = _$_Partner.fromJson;

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
  @override
  @JsonKey(ignore: true)
  _$$_PartnerCopyWith<_$_Partner> get copyWith =>
      throw _privateConstructorUsedError;
}

PartnerList _$PartnerListFromJson(Map<String, dynamic> json) {
  return _PartnerList.fromJson(json);
}

/// @nodoc
mixin _$PartnerList {
  List<Partner> get partners => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_PartnerListCopyWith<$Res>
    implements $PartnerListCopyWith<$Res> {
  factory _$$_PartnerListCopyWith(
          _$_PartnerList value, $Res Function(_$_PartnerList) then) =
      __$$_PartnerListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Partner> partners});
}

/// @nodoc
class __$$_PartnerListCopyWithImpl<$Res>
    extends _$PartnerListCopyWithImpl<$Res, _$_PartnerList>
    implements _$$_PartnerListCopyWith<$Res> {
  __$$_PartnerListCopyWithImpl(
      _$_PartnerList _value, $Res Function(_$_PartnerList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partners = null,
  }) {
    return _then(_$_PartnerList(
      partners: null == partners
          ? _value._partners
          : partners // ignore: cast_nullable_to_non_nullable
              as List<Partner>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PartnerList implements _PartnerList {
  const _$_PartnerList({required final List<Partner> partners})
      : _partners = partners;

  factory _$_PartnerList.fromJson(Map<String, dynamic> json) =>
      _$$_PartnerListFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PartnerList &&
            const DeepCollectionEquality().equals(other._partners, _partners));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_partners));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PartnerListCopyWith<_$_PartnerList> get copyWith =>
      __$$_PartnerListCopyWithImpl<_$_PartnerList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PartnerListToJson(
      this,
    );
  }
}

abstract class _PartnerList implements PartnerList {
  const factory _PartnerList({required final List<Partner> partners}) =
      _$_PartnerList;

  factory _PartnerList.fromJson(Map<String, dynamic> json) =
      _$_PartnerList.fromJson;

  @override
  List<Partner> get partners;
  @override
  @JsonKey(ignore: true)
  _$$_PartnerListCopyWith<_$_PartnerList> get copyWith =>
      throw _privateConstructorUsedError;
}
