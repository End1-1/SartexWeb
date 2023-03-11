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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductStatus _$ProductStatusFromJson(Map<String, dynamic> json) {
  return _ProductStatus.fromJson(json);
}

/// @nodoc
mixin _$ProductStatus {
  String get id => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get checkStatus => throw _privateConstructorUsedError;
  String get prod_status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_ProductStatusCopyWith<$Res>
    implements $ProductStatusCopyWith<$Res> {
  factory _$$_ProductStatusCopyWith(
          _$_ProductStatus value, $Res Function(_$_ProductStatus) then) =
      __$$_ProductStatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String branch, String checkStatus, String prod_status});
}

/// @nodoc
class __$$_ProductStatusCopyWithImpl<$Res>
    extends _$ProductStatusCopyWithImpl<$Res, _$_ProductStatus>
    implements _$$_ProductStatusCopyWith<$Res> {
  __$$_ProductStatusCopyWithImpl(
      _$_ProductStatus _value, $Res Function(_$_ProductStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? checkStatus = null,
    Object? prod_status = null,
  }) {
    return _then(_$_ProductStatus(
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
class _$_ProductStatus implements _ProductStatus {
  const _$_ProductStatus(
      {required this.id,
      required this.branch,
      required this.checkStatus,
      required this.prod_status});

  factory _$_ProductStatus.fromJson(Map<String, dynamic> json) =>
      _$$_ProductStatusFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.checkStatus, checkStatus) ||
                other.checkStatus == checkStatus) &&
            (identical(other.prod_status, prod_status) ||
                other.prod_status == prod_status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, branch, checkStatus, prod_status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductStatusCopyWith<_$_ProductStatus> get copyWith =>
      __$$_ProductStatusCopyWithImpl<_$_ProductStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductStatusToJson(
      this,
    );
  }
}

abstract class _ProductStatus implements ProductStatus {
  const factory _ProductStatus(
      {required final String id,
      required final String branch,
      required final String checkStatus,
      required final String prod_status}) = _$_ProductStatus;

  factory _ProductStatus.fromJson(Map<String, dynamic> json) =
      _$_ProductStatus.fromJson;

  @override
  String get id;
  @override
  String get branch;
  @override
  String get checkStatus;
  @override
  String get prod_status;
  @override
  @JsonKey(ignore: true)
  _$$_ProductStatusCopyWith<_$_ProductStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductStatusList _$ProductStatusListFromJson(Map<String, dynamic> json) {
  return _ProductStatusList.fromJson(json);
}

/// @nodoc
mixin _$ProductStatusList {
  List<ProductStatus> get productStatuses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_ProductStatusListCopyWith<$Res>
    implements $ProductStatusListCopyWith<$Res> {
  factory _$$_ProductStatusListCopyWith(_$_ProductStatusList value,
          $Res Function(_$_ProductStatusList) then) =
      __$$_ProductStatusListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductStatus> productStatuses});
}

/// @nodoc
class __$$_ProductStatusListCopyWithImpl<$Res>
    extends _$ProductStatusListCopyWithImpl<$Res, _$_ProductStatusList>
    implements _$$_ProductStatusListCopyWith<$Res> {
  __$$_ProductStatusListCopyWithImpl(
      _$_ProductStatusList _value, $Res Function(_$_ProductStatusList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productStatuses = null,
  }) {
    return _then(_$_ProductStatusList(
      productStatuses: null == productStatuses
          ? _value._productStatuses
          : productStatuses // ignore: cast_nullable_to_non_nullable
              as List<ProductStatus>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductStatusList implements _ProductStatusList {
  const _$_ProductStatusList(
      {required final List<ProductStatus> productStatuses})
      : _productStatuses = productStatuses;

  factory _$_ProductStatusList.fromJson(Map<String, dynamic> json) =>
      _$$_ProductStatusListFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductStatusList &&
            const DeepCollectionEquality()
                .equals(other._productStatuses, _productStatuses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_productStatuses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductStatusListCopyWith<_$_ProductStatusList> get copyWith =>
      __$$_ProductStatusListCopyWithImpl<_$_ProductStatusList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductStatusListToJson(
      this,
    );
  }
}

abstract class _ProductStatusList implements ProductStatusList {
  const factory _ProductStatusList(
          {required final List<ProductStatus> productStatuses}) =
      _$_ProductStatusList;

  factory _ProductStatusList.fromJson(Map<String, dynamic> json) =
      _$_ProductStatusList.fromJson;

  @override
  List<ProductStatus> get productStatuses;
  @override
  @JsonKey(ignore: true)
  _$$_ProductStatusListCopyWith<_$_ProductStatusList> get copyWith =>
      throw _privateConstructorUsedError;
}
