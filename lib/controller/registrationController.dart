import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_blog/model/registerModel.dart';
import 'package:my_blog/utilities/utilities.dart';

class RegistrationController with ChangeNotifier {
  RegisterModel registerModel = RegisterModel();
  bool loading = true;

  Future<RegisterModel> registerPostApi(
      String name, String email, String password) async {
    loading = true;
    notifyListeners();
    var response = await http
        .post(Uri.parse('http://192.168.1.75:8000/api/register'), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,

      // 'user': 0.toString(),
    });
    if (response.statusCode == 200) {
      loading = false;
      if (kDebugMode) {
        print('Registration Successfully');
      }
      var data = jsonDecode(response.body);
      registerModel = RegisterModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return registerModel;
    } else {
      loading = false;
      if (kDebugMode) {
        print(response.statusCode);
        print('Failed');
      }
      var data = jsonDecode(response.body);
      registerModel = RegisterModel.fromJson(data);
      notifyListeners();
      return registerModel;
    }
  }
}
