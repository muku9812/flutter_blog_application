import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_blog/model/loginModel.dart';

class LoginController with ChangeNotifier {
  LoginModel loginModel = LoginModel();
  bool loading = false;

  Future<LoginModel> loginProvider(String email, String password) async {
    loading = true;
    notifyListeners();
    var response =
        await http.post(Uri.parse('http://192.168.1.75:8000/api/login'), body: {
      'email': email,
      'password': password,
    });
    // http: //10.0.2.2:8000/api/login
    if (response.statusCode == 200) {
      loading = false;
      if (kDebugMode) {
        print('Login Successfully');
      }
      var data = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(data);
      notifyListeners();
      return loginModel;
    } else {
      loading = false;
      if (kDebugMode) {
        print('Failed');
      }
      var data = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(data);
      notifyListeners();
      return loginModel;
    }
  }
}
