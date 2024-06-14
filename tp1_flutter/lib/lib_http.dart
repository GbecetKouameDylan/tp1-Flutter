
import 'package:dio/dio.dart';
import 'package:tp1_flutter/transfert.dart';

Future<SigninResponse> signup(SignupRequest req) async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signup',
      data: req
    );
    print(response);
    return  SigninResponse.fromJson(response.data);

  }
  catch (e) {
    print(e);
    throw(e);
  }

}

Future<SigninResponse> signin(SigninRequest req) async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signin',
        data: req
    );
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<AddTaskRequest> Tache(AddTaskRequest req) async {
  try {
    var response = await Dio().post(
      'http://10.0.2.2:8080/api/add',

    );

    print(response);
    return AddTaskRequest.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future signout() async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signout',

    );
    print(response);
  } catch (e) {
    print(e);
    throw(e);
  }
}



Future<List<HomeItemResponse>> home() async {
  try {
    var response = await Dio().get(
        'http://10.0.2.2:8080/api/id/home',

    );
    var listeitem = response.data  as List;
    var liste = listeitem.map((elementJson){
      return HomeItemResponse.fromJson(elementJson);
    }).toList();
    print(response);
    return liste;
  } catch (e) {
    print(e);
    throw(e);
  }
}



