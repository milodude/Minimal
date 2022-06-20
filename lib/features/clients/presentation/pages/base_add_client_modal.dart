import 'package:coda_test/features/clients/presentation/bloc/clients/client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseAddClientModal extends StatelessWidget {
  const BaseAddClientModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (BuildContext context, ClientState state) {
        if (state is Saved) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text('New client saved!'),
          ));
          Navigator.of(context).pop();
        }

        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(state.errorMessage),
          ));
        }
      },
      child: Container(),
    );
  }
}
