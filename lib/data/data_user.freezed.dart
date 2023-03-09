// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataUser _$DataUserFromJson(Map<String, dynamic> json) {
  return _DataUser.fromJson(json);
}

/// @nodoc
mixin _$DataUser {
  int get id => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get active => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get middleName => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataUserCopyWith<DataUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataUserCopyWith<$Res> {
  factory $DataUserCopyWith(DataUser value, $Res Function(DataUser) then) =
      _$DataUserCopyWithImpl<$Res, DataUser>;
  @useResult
  $Res call(
      {int id,
      String branch,
      String active,
      String department,
      String email,
      String firstName,
      String lastName,
      String middleName,
      String position});
}

/// @nodoc
class _$DataUserCopyWithImpl<$Res, $Val extends DataUser>
    implements $DataUserCopyWith<$Res> {
  _$DataUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? active = null,
    Object? department = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? middleName = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: null == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataUserCopyWith<$Res> implements $DataUserCopyWith<$Res> {
  factory _$$_DataUserCopyWith(
          _$_DataUser value, $Res Function(_$_DataUser) then) =
      __$$_DataUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String branch,
      String active,
      String department,
      String email,
      String firstName,
      String lastName,
      String middleName,
      String position});
}

/// @nodoc
class __$$_DataUserCopyWithImpl<$Res>
    extends _$DataUserCopyWithImpl<$Res, _$_DataUser>
    implements _$$_DataUserCopyWith<$Res> {
  __$$_DataUserCopyWithImpl(
      _$_DataUser _value, $Res Function(_$_DataUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branch = null,
    Object? active = null,
    Object? department = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? middleName = null,
    Object? position = null,
  }) {
    return _then(_$_DataUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: null == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataUser with DiagnosticableTreeMixin implements _DataUser {
  const _$_DataUser(
      {required this.id,
      required this.branch,
      required this.active,
      required this.department,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.position});

  factory _$_DataUser.fromJson(Map<String, dynamic> json) =>
      _$$_DataUserFromJson(json);

  @override
  final int id;
  @override
  final String branch;
  @override
  final String active;
  @override
  final String department;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String middleName;
  @override
  final String position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataUser(id: $id, branch: $branch, active: $active, department: $department, email: $email, firstName: $firstName, lastName: $lastName, middleName: $middleName, position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataUser'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('branch', branch))
      ..add(DiagnosticsProperty('active', active))
      ..add(DiagnosticsProperty('department', department))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('middleName', middleName))
      ..add(DiagnosticsProperty('position', position));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, branch, active, department,
      email, firstName, lastName, middleName, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataUserCopyWith<_$_DataUser> get copyWith =>
      __$$_DataUserCopyWithImpl<_$_DataUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataUserToJson(
      this,
    );
  }
}

abstract class _DataUser implements DataUser {
  const factory _DataUser(
      {required final int id,
      required final String branch,
      required final String active,
      required final String department,
      required final String email,
      required final String firstName,
      required final String lastName,
      required final String middleName,
      required final String position}) = _$_DataUser;

  factory _DataUser.fromJson(Map<String, dynamic> json) = _$_DataUser.fromJson;

  @override
  int get id;
  @override
  String get branch;
  @override
  String get active;
  @override
  String get department;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get middleName;
  @override
  String get position;
  @override
  @JsonKey(ignore: true)
  _$$_DataUserCopyWith<_$_DataUser> get copyWith =>
      throw _privateConstructorUsedError;
}
