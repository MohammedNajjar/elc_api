import 'package:elc_api/helpers/helpers.dart';
import 'package:elc_api/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../api/controllers/auth_api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _tapGestureRecognizer=TapGestureRecognizer()..onTap=navigatorToRegisterScreen;
  }
  void navigatorToRegisterScreen(){
    Navigator.pushNamed(context, '/register_screen');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Center(child: Text('LOGIN')),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'Welcome back... ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const Text(
            'Enter your email & password ',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hint: 'Email',
            keyboardType: TextInputType.text,
            prefixIcon: Icons.email_outlined,
            obscurerText: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextField(
            hint: 'Password',
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock,
            obscurerText: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade700,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async =>await performlogin(),
              child: const Text('Login')),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
                text:  TextSpan(
              text: 'Don\t have account? ',
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  recognizer: _tapGestureRecognizer,
                    text: 'Create now!', style: const TextStyle(color: Colors.blue))
              ],
            )),
          )
        ],
      ),
    );
  }
  Future<void>performlogin()async{
    if (checkData()){
      await login();
    }
  }
  bool checkData(){
    if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data!',error: true);
    return false;
  }
  Future <void> login()async{
    bool status=await AuthApiController().login(context: context, email: _emailController.text, password: _passwordController.text);
    if(status)Navigator.pushReplacementNamed(context, '/category_screen');
  }

}
