import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../model/productModel.dart';

class ProductController with ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];

  Future<List<ProductModel>> getProducts() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if (response.statusCode == 200) {
      products = [];
      products.addAll(List<ProductModel>.from(
          jsonDecode(response.body.toString())
              .map((x) => ProductModel.fromJson(x))));
      notifyListeners();
      return products;
    }
    return products;
  }
}
