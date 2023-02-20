// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      groupID: json['groupID'] as String,
      userID: json['userID'] as String,
      userName: json['userName'] as String,
      bathTime: json['bathTime'] as int,
      order: json['order'] as int? ?? -1,
      currentIcon: json['currentIcon'] as int? ?? 0,
      myIcons:
          (json['myIcons'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [0],
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'groupID': instance.groupID,
      'userID': instance.userID,
      'userName': instance.userName,
      'bathTime': instance.bathTime,
      'order': instance.order,
      'currentIcon': instance.currentIcon,
      'myIcons': instance.myIcons,
    };
