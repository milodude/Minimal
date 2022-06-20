import 'package:coda_test/core/shared_widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/client.dart';
import '../bloc/clients/client_bloc.dart';
import '../widgets/search_no_results_found.dart';

///Widget that shows you a list of clients
class ClientsGridView extends StatelessWidget {
  final List<ClientData> clientsToShow;

  const ClientsGridView({
    Key? key,
    required this.clientsToShow,
  }) : super(key: key);

  Widget setupAlertDialoadContainer(BuildContext context, ClientData client) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Are you sure you want to delete ${client.firstName}, ${client.lastName} client?",
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CancelButton()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  fixedSize: const Size(159, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  var clientBloc = context.read<ClientBloc>();
                  clientBloc.add(DeleteClient(clientId: client.id));
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return clientsToShow.isEmpty
        ? const SearchNoResultsFound()
        : ListView.builder(
            itemCount: clientsToShow.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: const FlutterLogo(size: 56.0),
                  title: Text(
                    '${clientsToShow[index].firstName} ${clientsToShow[index].lastName}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    clientsToShow[index].email,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        )
                      ];
                    },
                    onSelected: (String value) {
                      //Todo: Implement delete functionality
                      if (value == 'delete') {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (BuildContext context) {
                              return BlocListener<ClientBloc, ClientState>(
                                listener: (context, state) {
                                  if (state is Error) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      duration: const Duration(seconds: 5),
                                      content: Text(state.errorMessage),
                                    ));
                                  }
                                  if (state is Saved) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      duration: Duration(seconds: 5),
                                      content: Text('Client Deleted!'),
                                    ));
                                    context
                                        .read<ClientBloc>()
                                        .add(const GetClients());
                                  }
                                },
                                child: BlocBuilder<ClientBloc, ClientState>(
                                  builder: (context, state) {
                                    return setupAlertDialoadContainer(
                                        context, clientsToShow[index]);
                                  },
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
              );
            });
  }
}
