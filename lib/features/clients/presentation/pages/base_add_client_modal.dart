import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/single_client/single_client_bloc.dart';

class BaseAddClientModal extends StatelessWidget {
  const BaseAddClientModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingleClientBloc, SingleClientState>(
      listener: (BuildContext context, SingleClientState state) {
        if (state is SingleClientSaved) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text('New client saved!'),
          ));
          Navigator.of(context).pop();
        }

        if (state is SingleClientError) {
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
