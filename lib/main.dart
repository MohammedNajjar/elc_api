import 'package:elc_api/prefs/shard_pref_controller.dart';
import 'package:elc_api/screens/auth/login_screen.dart';
import 'package:elc_api/screens/auth/register_screen.dart';
import 'package:elc_api/screens/category_screen.dart';
import 'package:elc_api/screens/launch_screen.dart';
import 'package:elc_api/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ShardPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen':(context)=> const LaunchScreen(),
        '/users_screen': (context)=>const UsersScreen(),
        '/login_screen': (context)=>const LoginScreen(),
        '/register_screen': (context)=>const RegisterScreen(),
        '/category_screen': (context)=>const CategoriesScreen(),
      },
    );
  }
}

