// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupData _$GroupDataFromJson(Map<String, dynamic> json) {
  return _GroupData.fromJson(json);
}

/// @nodoc
mixin _$GroupData {
  String get groupID => throw _privateConstructorUsedError;
  int get userCounts => throw _privateConstructorUsedError;
  bool get isSetOrder => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp? get groupStartTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupDataCopyWith<GroupData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDataCopyWith<$Res> {
  factory $GroupDataCopyWith(GroupData value, $Res Function(GroupData) then) =
      _$GroupDataCopyWithImpl<$Res, GroupData>;
  @useResult
  $Res call(
      {String groupID,
      int userCounts,
      bool isSetOrder,
      @TimestampConverter() Timestamp? groupStartTime});
}

/// @nodoc
class _$GroupDataCopyWithImpl<$Res, $Val extends GroupData>
    implements $GroupDataCopyWith<$Res> {
  _$GroupDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupID = null,
    Object? userCounts = null,
    Object? isSetOrder = null,
    Object? groupStartTime = freezed,
  }) {
    return _then(_value.copyWith(
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      userCounts: null == userCounts
          ? _value.userCounts
          : userCounts // ignore: cast_nullable_to_non_nullable
              as int,
      isSetOrder: null == isSetOrder
          ? _value.isSetOrder
          : isSetOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      groupStartTime: freezed == groupStartTime
          ? _value.groupStartTime
          : groupStartTime // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupDataCopyWith<$Res> implements $GroupDataCopyWith<$Res> {
  factory _$$_GroupDataCopyWith(
          _$_GroupData value, $Res Function(_$_GroupData) then) =
      __$$_GroupDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupID,
      int userCounts,
      bool isSetOrder,
      @TimestampConverter() Timestamp? groupStartTime});
}

/// @nodoc
class __$$_GroupDataCopyWithImpl<$Res>
    extends _$GroupDataCopyWithImpl<$Res, _$_GroupData>
    implements _$$_GroupDataCopyWith<$Res> {
  __$$_GroupDataCopyWithImpl(
      _$_GroupData _value, $Res Function(_$_GroupData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupID = null,
    Object? userCounts = null,
    Object? isSetOrder = null,
    Object? groupStartTime = freezed,
  }) {
    return _then(_$_GroupData(
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      userCounts: null == userCounts
          ? _value.userCounts
          : userCounts // ignore: cast_nullable_to_non_nullable
              as int,
      isSetOrder: null == isSetOrder
          ? _value.isSetOrder
          : isSetOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      groupStartTime: freezed == groupStartTime
          ? _value.groupStartTime
          : groupStartTime // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupData with DiagnosticableTreeMixin implements _GroupData {
  const _$_GroupData(
      {required this.groupID,
      required this.userCounts,
      this.isSetOrder = false,
      @TimestampConverter() this.groupStartTime});

  factory _$_GroupData.fromJson(Map<String, dynamic> json) =>
      _$$_GroupDataFromJson(json);

  @override
  final String groupID;
  @override
  final int userCounts;
  @override
  @JsonKey()
  final bool isSetOrder;
  @override
  @TimestampConverter()
  final Timestamp? groupStartTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GroupData(groupID: $groupID, userCounts: $userCounts, isSetOrder: $isSetOrder, groupStartTime: $groupStartTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupData'))
      ..add(DiagnosticsProperty('groupID', groupID))
      ..add(DiagnosticsProperty('userCounts', userCounts))
      ..add(DiagnosticsProperty('isSetOrder', isSetOrder))
      ..add(DiagnosticsProperty('groupStartTime', groupStartTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupData &&
            (identical(other.groupID, groupID) || other.groupID == groupID) &&
            (identical(other.userCounts, userCounts) ||
                other.userCounts == userCounts) &&
            (identical(other.isSetOrder, isSetOrder) ||
                other.isSetOrder == isSetOrder) &&
            (identical(other.groupStartTime, groupStartTime) ||
                other.groupStartTime == groupStartTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, groupID, userCounts, isSetOrder, groupStartTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupDataCopyWith<_$_GroupData> get copyWith =>
      __$$_GroupDataCopyWithImpl<_$_GroupData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupDataToJson(
      this,
    );
  }
}

abstract class _GroupData implements GroupData {
  const factory _GroupData(
      {required final String groupID,
      required final int userCounts,
      final bool isSetOrder,
      @TimestampConverter() final Timestamp? groupStartTime}) = _$_GroupData;

  factory _GroupData.fromJson(Map<String, dynamic> json) =
      _$_GroupData.fromJson;

  @override
  String get groupID;
  @override
  int get userCounts;
  @override
  bool get isSetOrder;
  @override
  @TimestampConverter()
  Timestamp? get groupStartTime;
  @override
  @JsonKey(ignore: true)
  _$$_GroupDataCopyWith<_$_GroupData> get copyWith =>
      throw _privateConstructorUsedError;
}
