import 'dart:ffi';
import 'dart:io';



import 'package:image_picker/image_picker.dart';
import 'package:tp1_flutter/transfert.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';




class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }
}

class UserSession {
  static UserSession? _instance;
  String? username;

  UserSession._();

  static UserSession getInstance() {
    _instance ??= UserSession._();
    return _instance!;
  }

  String? getUsername() {
    return username;
  }

  void setUsername(String username) {
    this.username = username;
  }
}


Future<SigninResponse> signup(SignupRequest req) async {
  try {
    var response = await SingletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signup',
      data: req.toJson(),
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
    var response = await SingletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signin',
        data: req.toJson()
    );
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<String> Tache(AddTaskRequest req) async {
  try {
    var response = await SingletonDio.getDio().post(
      'http://10.0.2.2:8080/api/add',data: req.toJson()

    );

    print(response);
    return "";
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future signout() async {
  try {
    var response = await SingletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signout',

    );
    print(response);
  } catch (e) {
    print(e);
    throw(e);
  }
}



Future<List<HomeItemPhotoResponse>> home() async {
  try {
    var response = await SingletonDio.getDio().get(
        'http://10.0.2.2:8080/api/home/photo',

    );
    var listeitem = response.data  as List;
    var liste = listeitem.map((elementJson){
      return HomeItemPhotoResponse.fromJson(elementJson);
    }).toList();
    print(response);
    return liste;
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<TaskDetailPhotoResponse> Detail(int id) async {
  try {
    var response = await SingletonDio.getDio().get(
      'http://10.0.2.2:8080/api/detail/photo/'+id.toString()
    );

    print(response);
    return TaskDetailPhotoResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<String> sendPicture(int taskID, File file) async {
  try{
    FormData formData = FormData.fromMap({
      "taskID": taskID,
      "file": await MultipartFile.fromFile(file.path)
    });
    var url = "http://10.0.2.2:8080/file";
    var response = await SingletonDio.getDio().post(url, data: formData);
    print(response.data);
    return "";
  }catch (e) {
    print(e);
    throw(e);
  }



}


class Long {
  final int value;

  Long(this.value);
}












