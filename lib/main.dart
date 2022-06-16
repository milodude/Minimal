import 'package:coda_test/features/login/presentation/pages/login_base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(textTheme: GoogleFonts.dmSansTextTheme()),
      home: const LoginBase()
      );
  }
}
