import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uzmbs/pages/splash_screen.dart';
import 'package:uzmbs/sample.dart';
import 'login.dart';

void main() async {
  /// TODO: update Supabase credentials with your own
  await Supabase.initialize(
    url: 'https://xulmdkmyhyegxpbgzjdq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1bG1ka215aHllZ3hwYmd6amRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ5ODE4MTEsImV4cCI6MjAyMDU1NzgxMX0.wSBAUHIVnRkDpKrhSrnn4FxFxFXIvaScSa5XalzMs60',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: SamplePage(),
      home: SplashPage(),
    );
  }
}
