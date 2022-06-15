import 'package:coda_test/features/login/presentation/pages/clients_page.dart';
import 'package:coda_test/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/user/user_bloc.dart';

class LoginBase extends StatelessWidget {
  static const String routeName = '/Wrapper';

  const LoginBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      key: const Key('BlocProvider'),
      create: (BuildContext context) => sl<UserBloc>(),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return const LoginPage();
          } else if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            //Todo: This page must be done in a new feature.
            return const ClientsPage();
          } else if (state is Error) {
            return const Text('Error');
          }
          return const Text('Unknown error occurred');
          // We're going to also check for the other states
        },
      ),
    );
  }
  // Widget build(BuildContext context) {

  //   final user = ReadContext(context).read<UserBloc>();
  //   return user.state.userinfo.id == 0 || user.state.userinfo.accessToken.isEmpty ?
  //     const LoginPage() :
  //     const ClientsPage();
  // }
}
