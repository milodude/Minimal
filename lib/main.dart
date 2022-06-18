import 'package:coda_test/features/clients/presentation/bloc/client/client_bloc.dart';
import 'package:coda_test/features/clients/presentation/pages/clients_page.dart';
import 'package:coda_test/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/login/presentation/bloc/user/user_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
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
      initialRoute: LoginPage.routeName,
      routes: {
        '/': (context) => BlocProvider.value(value: sl<UserBloc>(),child: const LoginPage(),),
        ClientsPage.routeName: (context) => BlocProvider.value(value: sl<ClientBloc>(),child: const ClientsPage(),),
      },
    );
  }
}
