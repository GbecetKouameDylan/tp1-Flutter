
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

  } catch (e) {
    print(e);
    throw(e);
  }


}

