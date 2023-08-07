import 'dart:convert';

import 'package:elc_api/api/api_settings.dart';
import 'package:elc_api/models/api_base_response.dart';
import 'package:elc_api/models/category.dart';
import 'package:elc_api/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiController {
  Future<List<User>> getUser() async {
    var url = Uri.parse(ApiSettings.users);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ApiBaseResponse apiBaseResponse = ApiBaseResponse.fromJson(jsonResponse);
      return apiBaseResponse.list;
    }
    return [];
  }


  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var categoriesJsonResponse = jsonDecode(response.body)['data'] as List;
     return categoriesJsonResponse
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
}
