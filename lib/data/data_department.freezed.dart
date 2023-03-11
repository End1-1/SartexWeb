// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_department.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataDepartment _$DataDepartmentFromJson(Map<String, dynamic> json) {
  return _DataDepartment.fromJson(json);
}

/// @nodoc
mixin _$DataDepartment {
  String get id => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get patasxanatu => throw _privateConstructorUsedError;
  String get short_name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataDepartmentCopyWith<DataDepartment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataDepartmentCopyWith<$Res> {
  factory $DataDepartmentCopyWith(
          DataDepartment value, $Res Function(DataDepartment) then) =
      _$DataDepartmentCopyWithImpl<$Res, DataDepartment>;
  @useResult
  $Res call(
      {String id,
      String branch,
      String department,
      String patasxanatu,
      String short_name,
      String type});
}

/// @nodoc
class _$DataDepartmentCopyWithImpl<$Res, $Val extends DataDepartment>
    implements $DataDepartmentCopyWith<$Res> {
  _$DataDepartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? department = null,
    Object? patasxanatu = null,
    Object? short_name = null,
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
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      patasxanatu: null == patasxanatu
          ? _value.patasxanatu
          : patasxanatu // ignore: cast_nullable_to_non_nullable
              as String,
      short_name: null == short_name
          ? _value.short_name
          : short_name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataDepartmentCopyWith<$Res>
    implements $DataDepartmentCopyWith<$Res> {
  factory _$$_DataDepartmentCopyWith(
          _$_DataDepartment value, $Res Function(_$_DataDepartment) then) =
      __$$_DataDepartmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String branch,
      String department,
      String patasxanatu,
      String short_name,
      String type});
}

/// @nodoc
class __$$_DataDepartmentCopyWithImpl<$Res>
    extends _$DataDepartmentCopyWithImpl<$Res, _$_DataDepartment>
    implements _$$_DataDepartmentCopyWith<$Res> {
  __$$_DataDepartmentCopyWithImpl(
      _$_DataDepartment _value, $Res Function(_$_DataDepartment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? department = null,
    Object? patasxanatu = null,
    Object? short_name = null,
    Object? type = null,
  }) {
    return _then(_$_DataDepartment(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      patasxanatu: null == patasxanatu
          ? _value.patasxanatu
          : patasxanatu // ignore: cast_nullable_to_non_nullable
              as String,
      short_name: null == short_name
          ? _value.short_name
          : short_name // ignore: cast_nullable_to_non_nullable
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
class _$_DataDepartment implements _DataDepartment {
  const _$_DataDepartment(
      {required this.id,
      required this.branch,
      required this.department,
      required this.patasxanatu,
      required this.short_name,
      required this.type});

  factory _$_DataDepartment.fromJson(Map<String, dynamic> json) =>
      _$$_DataDepartmentFromJson(json);

  @override
  final String id;
  @override
  final String branch;
  @override
  final String department;
  @override
  final String patasxanatu;
  @override
  final String short_name;
  @override
  final String type;

  @override
  String toString() {
    return 'DataDepartment(id: $id, branch: $branch, department: $department, patasxanatu: $patasxanatu, short_name: $short_name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataDepartment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.patasxanatu, patasxanatu) ||
                other.patasxanatu == patasxanatu) &&
            (identical(other.short_name, short_name) ||
                other.short_name == short_name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, branch, department, patasxanatu, short_name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataDepartmentCopyWith<_$_DataDepartment> get copyWith =>
      __$$_DataDepartmentCopyWithImpl<_$_DataDepartment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataDepartmentToJson(
      this,
    );
  }
}

abstract class _DataDepartment implements DataDepartment {
  const factory _DataDepartment(
      {required final String id,
      required final String branch,
      required final String department,
      required final String patasxanatu,
      required final String short_name,
      required final String type}) = _$_DataDepartment;

  factory _DataDepartment.fromJson(Map<String, dynamic> json) =
      _$_DataDepartment.fromJson;

  @override
  String get id;
  @override
  String get branch;
  @override
  String get department;
  @override
  String get patasxanatu;
  @override
  String get short_name;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_DataDepartmentCopyWith<_$_DataDepartment> get copyWith =>
      throw _privateConstructorUsedError;
}

DataDepartmentList _$DataDepartmentListFromJson(Map<String, dynamic> json) {
  return _DataDepartmentList.fromJson(json);
}

/// @nodoc
mixin _$DataDepartmentList {
  List<DataDepartment> get departments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataDepartmentListCopyWith<DataDepartmentList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataDepartmentListCopyWith<$Res> {
  factory $DataDepartmentListCopyWith(
          DataDepartmentList value, $Res Function(DataDepartmentList) then) =
      _$DataDepartmentListCopyWithImpl<$Res, DataDepartmentList>;
  @useResult
  $Res call({List<DataDepartment> departments});
}

/// @nodoc
class _$DataDepartmentListCopyWithImpl<$Res, $Val extends DataDepartmentList>
    implements $DataDepartmentListCopyWith<$Res> {
  _$DataDepartmentListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departments = null,
  }) {
    return _then(_value.copyWith(
      departments: null == departments
          ? _value.departments
          : departments // ignore: cast_nullable_to_non_nullable
              as List<DataDepartment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataDepartmentListCopyWith<$Res>
    implements $DataDepartmentListCopyWith<$Res> {
  factory _$$_DataDepartmentListCopyWith(_$_DataDepartmentList value,
          $Res Function(_$_DataDepartmentList) then) =
      __$$_DataDepartmentListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DataDepartment> departments});
}

/// @nodoc
class __$$_DataDepartmentListCopyWithImpl<$Res>
    extends _$DataDepartmentListCopyWithImpl<$Res, _$_DataDepartmentList>
    implements _$$_DataDepartmentListCopyWith<$Res> {
  __$$_DataDepartmentListCopyWithImpl(
      _$_DataDepartmentList _value, $Res Function(_$_DataDepartmentList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departments = null,
  }) {
    return _then(_$_DataDepartmentList(
      departments: null == departments
          ? _value._departments
          : departments // ignore: cast_nullable_to_non_nullable
              as List<DataDepartment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataDepartmentList implements _DataDepartmentList {
  const _$_DataDepartmentList({required final List<DataDepartment> departments})
      : _departments = departments;

  factory _$_DataDepartmentList.fromJson(Map<String, dynamic> json) =>
      _$$_DataDepartmentListFromJson(json);

  final List<DataDepartment> _departments;
  @override
  List<DataDepartment> get departments {
    if (_departments is EqualUnmodifiableListView) return _departments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_departments);
  }

  @override
  String toString() {
    return 'DataDepartmentList(departments: $departments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataDepartmentList &&
            const DeepCollectionEquality()
                .equals(other._departments, _departments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_departments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataDepartmentListCopyWith<_$_DataDepartmentList> get copyWith =>
      __$$_DataDepartmentListCopyWithImpl<_$_DataDepartmentList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataDepartmentListToJson(
      this,
    );
  }
}

abstract class _DataDepartmentList implements DataDepartmentList {
  const factory _DataDepartmentList(
          {required final List<DataDepartment> departments}) =
      _$_DataDepartmentList;

  factory _DataDepartmentList.fromJson(Map<String, dynamic> json) =
      _$_DataDepartmentList.fromJson;

  @override
  List<DataDepartment> get departments;
  @override
  @JsonKey(ignore: true)
  _$$_DataDepartmentListCopyWith<_$_DataDepartmentList> get copyWith =>
      throw _privateConstructorUsedError;
}
