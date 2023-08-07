import 'dart:convert';
import 'dart:io';

import 'package:elc_api/api/api_settings.dart';
import 'package:elc_api/models/students.dart';
import 'package:elc_api/prefs/shard_pref_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../helpers/helpers.dart';

class AuthApiController with Helpers {
  Future<bool> register(
      {required BuildContext context, required Student students}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      'full_name': students.fullName,
      'email': students.email,
      'password': students.password,
      'gender': students.gender,
    });
    if (response.statusCode == 201) {
      showSnackBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }
  Future<bool> login({required BuildContext context,required String email,required String password})async{
    var url=Uri.parse(ApiSettings.login);
    var response =await http.post(url,body:{
      'email':email,
      'password':password,

    });
    if (response.statusCode==200){
      var jsonObject=jsonDecode(response.body)['object'];
      Student students =Student.fromJson(jsonObject);
      ShardPrefController().save(student: students);

      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          );
      return true;
    }else if(response.statusCode==400){
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;

  }
  Future<bool>logout()async{
    var url = Uri.parse(ApiSettings.logout);
    var response=await http.get(url,headers: {
      HttpHeaders.authorizationHeader:ShardPrefController().token,
      HttpHeaders.acceptHeader:'application/json'
    });
    print(response.statusCode);
    if (response.statusCode==200 || response.statusCode==401){
      ShardPrefController().clear();
      return true;
    }
    return false;
  }
}
