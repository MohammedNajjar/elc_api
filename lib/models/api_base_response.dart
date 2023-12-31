
import 'package:elc_api/models/user.dart';

class ApiBaseResponse {
  late bool status;
  late String message;
  late List<User> list;

  ApiBaseResponse.fromJson (Map<String, dynamic> json) {
    status = json[ 'status'];
    message = json[ 'message'];
    if (json[ 'list' ] != null) {
      list = <User>[];
      json[ 'list'].forEach((jsonResponse) {
        list.add(User.fromJson(jsonResponse));
      });
    }
  }
}