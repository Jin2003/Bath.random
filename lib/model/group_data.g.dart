// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'group_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupData _$$_GroupDataFromJson(Map<String, dynamic> json) => _$_GroupData(
      groupID: json['groupID'] as String,
      userCounts: json['userCounts'] as int,
      isSetOrder: json['isSetOrder'] as bool? ?? false,
      groupStartTime: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['groupStartTime'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_GroupDataToJson(_$_GroupData instance) =>
    <String, dynamic>{
      'groupID': instance.groupID,
      'userCounts': instance.userCounts,
      'isSetOrder': instance.isSetOrder,
      'groupStartTime': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.groupStartTime, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
