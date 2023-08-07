import 'package:elc_api/api/controllers/auth_api_controller.dart';
import 'package:elc_api/helpers/helpers.dart';
import 'package:elc_api/models/students.dart';
import 'package:elc_api/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _passwordController;
  String _gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Center(child: Text('Register')),
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
            hint: 'Full Name',
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person,
            obscurerText: false,
            controller: _fullNameController,
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
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
          Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Expanded(
                child: RadioListTile<String>(

                    title: const Text('Mail'),
                    contentPadding: EdgeInsets.zero,
                    value: 'M',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _gender = value;
                        });
                      }
                    }),
              ),
              Expanded(
                child: RadioListTile<String>(
                    title: const Text('Female'),
                    contentPadding: EdgeInsets.zero,
                    value: 'F',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        if (value != null) {
                          setState(() {
                            _gender = value;
                          });
                        }
                      });
                    }),
              )
            ],
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
              onPressed: () async =>await performRegister(),
              child: const Text('Register'))
        ],
      ),
    );
  }

  Future<void>performRegister()async{
    if (checkData()){
      await register();
    }
  }
  bool checkData(){
  if(_fullNameController.text.isNotEmpty&&_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
  return true;
  }
  showSnackBar(context: context, message: 'Enter required data!',error: true);
  return false;
  }
  Future <void> register()async{
    bool status=await AuthApiController().register(context: context, students: students);
    if(status)Navigator.pop(context);
  }
  Student get students{
    Student students=Student();
    students.fullName=_fullNameController.text;
    students.email=_emailController.text;
    students.password=_passwordController.text;
    students.gender=_gender;
    return students;

  }

}
