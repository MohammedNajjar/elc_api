import 'package:elc_api/models/students.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum PrefKeys{
  loggedIn,fullName,email,gender,token
}
class ShardPrefController{
  static final ShardPrefController _instance= ShardPrefController._();
  ShardPrefController._();
  late SharedPreferences _sharedPreferences;
  factory ShardPrefController(){
    return _instance;

  }

  Future<void> initPref () async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<void> save ({required Student student}) async {
await _sharedPreferences.setBool (PrefKeys.loggedIn.toString(), true);
await _sharedPreferences.setString(PrefKeys.fullName.toString(),student.fullName);
await _sharedPreferences.setString(PrefKeys.email.toString(), student.email);
await _sharedPreferences. setString (PrefKeys. gender. toString(), student. gender);
await _sharedPreferences.setString(PrefKeys.token.toString(), 'Bearer '+student. token);
}
  bool get loggedIn =>_sharedPreferences.getBool(PrefKeys.loggedIn.toString())?? false;

  String get token=> _sharedPreferences.getString(PrefKeys.token.toString())??'';
  Future<bool> clear () async{
   return await _sharedPreferences.clear();
    }
}