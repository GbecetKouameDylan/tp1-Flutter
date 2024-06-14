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

Future<AddTaskRequest> Tache(AddTaskRequest req) async {
  try {
    var response = await SingletonDio.getDio().post(
      'http://10.0.2.2:8080/api/add',data: req.toJson()

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
    var response = await SingletonDio.getDio().post(
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
    var response = await SingletonDio.getDio().get(
        'http://10.0.2.2:8080/api/home',

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




