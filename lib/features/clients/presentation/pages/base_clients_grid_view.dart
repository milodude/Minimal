import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/clients/client_bloc.dart';
import 'clients_grid_view.dart';

class BaseClientsGridView extends StatelessWidget {
  const BaseClientsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state is Saved) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.greenAccent,
            duration: Duration(seconds: 5),
            content: Text('Client saved'),
          ));
        }
      },
      child: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state is Initial) {
            context.read<ClientBloc>().add(const GetClients());
          } else if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded || state is Saved) {
            return ClientsGridView(
              clientsToShow: state.clientDataToShow,
            );
          } else if (state is Error) {
            return const Center(
                child: Text(
                    'Error while trying to retrieve data from the backend'));
          }
          return const Text('Unknown error occurred');
        },
      ),
    );
  }
}
