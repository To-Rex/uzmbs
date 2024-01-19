import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uzmbs/res/colors.dart';
import 'package:uzmbs/sample.dart';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SamplePage(),
          ),
        );
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    const webClientId = '403307795191-5dg6q7kkpg5umnefdt537emjbd2kv1vj.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';


    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: '403307795191-rk1pqd5puepkpg3h7bqlld2gscultamd.apps.googleusercontent.com',
      clientId: Platform.isAndroid ? webClientId : iosClientId,
      serverClientId: webClientId,

    );
    print('googleSignIn----: ${googleSignIn.currentUser?.email}');
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      print('No Access Token found.');
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      print('No ID Token found.');
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: AppColors.backgroundColor,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fon.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*SizedBox(width: w),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: h * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: h * 0.05,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),*/
            //asswts in logo jpg
            const Spacer(),
            SizedBox(height: h * 0.05),
            GoogleAuthButton(
              style: AuthButtonStyle(
                width: MediaQuery.of(context).size.width * 0.8,
                height: h * 0.05,
                buttonColor: AppColors.whiteColor,
                textStyle: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                try {
                  await _googleSignIn();
                } catch (e) {
                  print('Error: $e');
                }
              },
            ),
            SizedBox(height: h * 0.05),
          ],
        ),
      )
    );
  }
}
