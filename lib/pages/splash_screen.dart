import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uzmbs/res/colors.dart';
import 'package:uzmbs/sample.dart';
import '../login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(seconds: 3);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Future.delayed(duration, () async {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SamplePage()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: h * 0.3),
          Center(
            child: Container(
              width: w * 0.5,
              height: h * 0.1,
              decoration: BoxDecoration(
                //radius 10
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              const CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              SizedBox(width: w * 0.05),
              Text('Loading...', style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: w * 0.05,
              )),
              const Spacer(),
            ],
          ),
          SizedBox(height: h * 0.1)
        ],
      )
    );
  }
}