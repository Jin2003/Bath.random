import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group_data.freezed.dart';
part 'group_data.g.dart';

@freezed
class GroupData with _$GroupData {
  const factory GroupData({
    required String groupID,
    required int userCounts,
    @Default(false) bool isSetOrder,
    @TimestampConverter() Timestamp? groupStartTime,
  }) = _GroupData;

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);
}

class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Timestamp timestamp) {
    return timestamp;
  }

  @override
  Timestamp toJson(Timestamp date) => date;
}
