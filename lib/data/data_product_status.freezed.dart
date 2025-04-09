// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_product_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductStatus _$ProductStatusFromJson(Map<String, dynamic> json) {
  return _ProductStatus.fromJson(json);
}

/// @nodoc
mixin _$ProductStatus {
  String get id => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get checkStatus => throw _privateConstructorUsedError;
  String get prod_status => throw _privateConstructorUsedError;

  /// Serializes this ProductStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductStatusCopyWith<ProductStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStatusCopyWith<$Res> {
  factory $ProductStatusCopyWith(
          ProductStatus value, $Res Function(ProductStatus) then) =
      _$ProductStatusCopyWithImpl<$Res, ProductStatus>;
  @useResult
  $Res call({String id, String branch, String checkStatus, String prod_status});
}

/// @nodoc
class _$ProductStatusCopyWithImpl<$Res, $Val extends ProductStatus>
    implements $ProductStatusCopyWith<$Res> {
  _$ProductStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? checkStatus = null,
    Object? prod_status = null,
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
      checkStatus: null == checkStatus
          ? _value.checkStatus
          : checkStatus // ignore: cast_nullable_to_non_nullable
              as String,
      prod_status: null == prod_status
          ? _value.prod_status
          : prod_status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductStatusImplCopyWith<$Res>
    implements $ProductStatusCopyWith<$Res> {
  factory _$$ProductStatusImplCopyWith(
          _$ProductStatusImpl value, $Res Function(_$ProductStatusImpl) then) =
      __$$ProductStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String branch, String checkStatus, String prod_status});
}

/// @nodoc
class __$$ProductStatusImplCopyWithImpl<$Res>
    extends _$ProductStatusCopyWithImpl<$Res, _$ProductStatusImpl>
    implements _$$ProductStatusImplCopyWith<$Res> {
  __$$ProductStatusImplCopyWithImpl(
      _$ProductStatusImpl _value, $Res Function(_$ProductStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? checkStatus = null,
    Object? prod_status = null,
  }) {
    return _then(_$ProductStatusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      checkStatus: null == checkStatus
          ? _value.checkStatus
          : checkStatus // ignore: cast_nullable_to_non_nullable
              as String,
      prod_status: null == prod_status
          ? _value.prod_status
          : prod_status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductStatusImpl implements _ProductStatus {
  const _$ProductStatusImpl(
      {required this.id,
      required this.branch,
      required this.checkStatus,
      required this.prod_status});

  factory _$ProductStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductStatusImplFromJson(json);

  @override
  final String id;
  @override
  final String branch;
  @override
  final String checkStatus;
  @override
  final String prod_status;

  @override
  String toString() {
    return 'ProductStatus(id: $id, branch: $branch, checkStatus: $checkStatus, prod_status: $prod_status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.checkStatus, checkStatus) ||
                other.checkStatus == checkStatus) &&
            (identical(other.prod_status, prod_status) ||
                other.prod_status == prod_status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, branch, checkStatus, prod_status);

  /// Create a copy of ProductStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStatusImplCopyWith<_$ProductStatusImpl> get copyWith =>
      __$$ProductStatusImplCopyWithImpl<_$ProductStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductStatusImplToJson(
      this,
    );
  }
}

abstract class _ProductStatus implements ProductStatus {
  const factory _ProductStatus(
      {required final String id,
      required final String branch,
      required final String checkStatus,
      required final String prod_status}) = _$ProductStatusImpl;

  factory _ProductStatus.fromJson(Map<String, dynamic> json) =
      _$ProductStatusImpl.fromJson;

  @override
  String get id;
  @override
  String get branch;
  @override
  String get checkStatus;
  @override
  String get prod_status;

  /// Create a copy of ProductStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductStatusImplCopyWith<_$ProductStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductStatusList _$ProductStatusListFromJson(Map<String, dynamic> json) {
  return _ProductStatusList.fromJson(json);
}

/// @nodoc
mixin _$ProductStatusList {
  List<ProductStatus> get productStatuses => throw _privateConstructorUsedError;

  /// Serializes this ProductStatusList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductStatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductStatusListCopyWith<ProductStatusList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStatusListCopyWith<$Res> {
  factory $ProductStatusListCopyWith(
          ProductStatusList value, $Res Function(ProductStatusList) then) =
      _$ProductStatusListCopyWithImpl<$Res, ProductStatusList>;
  @useResult
  $Res call({List<ProductStatus> productStatuses});
}

/// @nodoc
class _$ProductStatusListCopyWithImpl<$Res, $Val extends ProductStatusList>
    implements $ProductStatusListCopyWith<$Res> {
  _$ProductStatusListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductStatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productStatuses = null,
  }) {
    return _then(_value.copyWith(
      productStatuses: null == productStatuses
          ? _value.productStatuses
          : productStatuses // ignore: cast_nullable_to_non_nullable
              as List<ProductStatus>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductStatusListImplCopyWith<$Res>
    implements $ProductStatusListCopyWith<$Res> {
  factory _$$ProductStatusListImplCopyWith(_$ProductStatusListImpl value,
          $Res Function(_$ProductStatusListImpl) then) =
      __$$ProductStatusListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductStatus> productStatuses});
}

/// @nodoc
class __$$ProductStatusListImplCopyWithImpl<$Res>
    extends _$ProductStatusListCopyWithImpl<$Res, _$ProductStatusListImpl>
    implements _$$ProductStatusListImplCopyWith<$Res> {
  __$$ProductStatusListImplCopyWithImpl(_$ProductStatusListImpl _value,
      $Res Function(_$ProductStatusListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductStatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productStatuses = null,
  }) {
    return _then(_$ProductStatusListImpl(
      productStatuses: null == productStatuses
          ? _value._productStatuses
          : productStatuses // ignore: cast_nullable_to_non_nullable
              as List<ProductStatus>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductStatusListImpl implements _ProductStatusList {
  const _$ProductStatusListImpl(
      {required final List<ProductStatus> productStatuses})
      : _productStatuses = productStatuses;

  factory _$ProductStatusListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductStatusListImplFromJson(json);

  final List<ProductStatus> _productStatuses;
  @override
  List<ProductStatus> get productStatuses {
    if (_productStatuses is EqualUnmodifiableListView) return _productStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productStatuses);
  }

  @override
  String toString() {
    return 'ProductStatusList(productStatuses: $productStatuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStatusListImpl &&
            const DeepCollectionEquality()
                .equals(other._productStatuses, _productStatuses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_productStatuses));

  /// Create a copy of ProductStatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStatusListImplCopyWith<_$ProductStatusListImpl> get copyWith =>
      __$$ProductStatusListImplCopyWithImpl<_$ProductStatusListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductStatusListImplToJson(
      this,
    );
  }
}

abstract class _ProductStatusList implements ProductStatusList {
  const factory _ProductStatusList(
          {required final List<ProductStatus> productStatuses}) =
      _$ProductStatusListImpl;

  factory _ProductStatusList.fromJson(Map<String, dynamic> json) =
      _$ProductStatusListImpl.fromJson;

  @override
  List<ProductStatus> get productStatuses;

  /// Create a copy of ProductStatusList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductStatusListImplCopyWith<_$ProductStatusListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
