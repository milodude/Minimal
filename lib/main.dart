import 'package:coda_test/features/clients/presentation/bloc/clients/client_bloc.dart';
import 'package:coda_test/router_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/login/presentation/bloc/user/user_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  await di.init();
  runApp(ModularApp(module: AppModule(), child: const AppState()));
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClientBloc>(create: (_) => sl<ClientBloc>()),
        BlocProvider<UserBloc>(create: (_) => sl<UserBloc>()),
      ],
      child: const TestCoda(),
    );
  }
}

class TestCoda extends StatelessWidget {
  const TestCoda({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(textTheme: GoogleFonts.dmSansTextTheme()),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}

