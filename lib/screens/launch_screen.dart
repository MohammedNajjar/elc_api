import 'package:elc_api/prefs/shard_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
     String route=ShardPrefController().loggedIn ? '/category_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade800,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(

            image: AssetImage('assets/layer_2.svg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/layer_2.svg',
            width: 200,
            height: 200,
          ),
        ),
      ),

    );
  }
}
