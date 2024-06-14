


import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';


/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'transfert.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class SignupRequest {

  SignupRequest();

  String username = "";
  String password = "";

  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class SigninResponse {

  SigninResponse();

  String username = "";

  factory SigninResponse.fromJson(Map<String, dynamic> json) => _$SigninResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}
@JsonSerializable()

class SigninRequest {

  SigninRequest();

  String username = "";
  String password = "";

  factory SigninRequest.fromJson(Map<String, dynamic> json) => _$SigninRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()

class AddTaskRequest {

  AddTaskRequest();

  String name = "";
  DateTime deadline = DateTime(2024,6,14);

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()

class HomeItemResponse {

  HomeItemResponse();

  String name = "";
  DateTime deadline = DateTime(2024,6,14);
  int percentageDone = 0;
  double percentageTimeSpent = 0.0;

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) => _$HomeItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);
}

@JsonSerializable()
class  TaskDetailResponse{

  TaskDetailResponse();

  String name = "";
  DateTime deadline = DateTime(2024,6,14);
  int percentageDone = 2;
  double percentageTimeSpent=0.0;

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
}

@JsonSerializable()
class TrucAvecUneDate {
  TrucAvecUneDate();

  // TODO c'est cette annotation qui permet de override la conversion par defaut
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime date = DateTime.now();

  factory TrucAvecUneDate.fromJson(Map<String, dynamic> json) =>
      _$TrucAvecUneDateFromJson(json);

  Map<String, dynamic> toJson() => _$TrucAvecUneDateToJson(this);
}

// TODO ici on force le format de la date et on fournit les fonctions de conversion dans les 2 sens
final _dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

DateTime _fromJson(String date) => _dateFormatter.parse(date);

String _toJson(DateTime date) => _dateFormatter.format(date);







