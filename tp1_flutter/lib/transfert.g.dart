// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) =>
    SigninResponse()..username = json['username'] as String;

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) =>
    SigninRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) =>
    AddTaskRequest()
      ..name = json['name'] as String
      ..deadline = DateTime.parse(json['deadline'] as String);

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
    };

HomeItemPhotoResponse _$HomeItemPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    HomeItemPhotoResponse()
      ..id = (json['id'] as num).toInt()
      ..name = json['name'] as String
      ..deadline = DateTime.parse(json['deadline'] as String)
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toDouble()
      ..photoId = (json['photoId'] as num).toInt();

Map<String, dynamic> _$HomeItemPhotoResponseToJson(
        HomeItemPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'photoId': instance.photoId,
    };

TaskDetailPhotoResponse _$TaskDetailPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    TaskDetailPhotoResponse()
      ..id = (json['id'] as num).toInt()
      ..name = json['name'] as String
      ..deadline = DateTime.parse(json['deadline'] as String)
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toDouble()
      ..photoId = (json['photoId'] as num).toInt();

Map<String, dynamic> _$TaskDetailPhotoResponseToJson(
        TaskDetailPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'photoId': instance.photoId,
    };

TrucAvecUneDate _$TrucAvecUneDateFromJson(Map<String, dynamic> json) =>
    TrucAvecUneDate()..date = _fromJson(json['date'] as String);

Map<String, dynamic> _$TrucAvecUneDateToJson(TrucAvecUneDate instance) =>
    <String, dynamic>{
      'date': _toJson(instance.date),
    };
