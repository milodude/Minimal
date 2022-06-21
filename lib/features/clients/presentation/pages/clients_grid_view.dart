import 'package:coda_test/core/shared_widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/images.dart';
import '../../domain/entities/client.dart';
import '../bloc/clients/client_bloc.dart';
import '../widgets/search_no_results_found.dart';
import 'base_add_edit_client_modal.dart';

///Widget that shows you a list of clients
class ClientsGridView extends StatelessWidget {
  final List<ClientData> clientsToShow;

  const ClientsGridView({
    Key? key,
    required this.clientsToShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return clientsToShow.isEmpty
        ? const SearchNoResultsFound()
        : ListView.builder(
            itemCount: clientsToShow.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 5),
                  child: ListTile(
                    leading: _getPhoto(index),
                    title: _getFirstLastName(index),
                    subtitle: _getEmail(index),
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
                        if (value == 'delete') {
                          _showDeleteDialog(context, index);
                        }
                        if (value == 'edit') {
                          _showEditModal(context, index);
                        }
                      },
                    ),
                  ),
                ),
              );
            });
  }

  Future<Object?> _showEditModal(BuildContext context, int index) {
    return showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          transitionDuration:
                              const Duration(milliseconds: 300),
                          transitionBuilder: (context, animation,
                              secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return SafeArea(
                              child: Material(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: BaseAddEditClientModal(
                                      title: 'Edit client',
                                      client: clientsToShow[index],
                                    )),
                              ),
                            );
                          },
                        );
  }

  Future<dynamic> _showDeleteDialog(BuildContext context, int index) {
    return showDialog(
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
                          },
                        );
  }

  Text _getEmail(int index) {
    return Text(
                    clientsToShow[index].email,
                    style: const TextStyle(fontSize: 12),
                  );
  }

  Text _getFirstLastName(int index) {
    return Text(
                    '${clientsToShow[index].firstName} ${clientsToShow[index].lastName}',
                    style: const TextStyle(fontSize: 14),
                  );
  }

  CircleAvatar _getPhoto(int index) {
    return CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: (clientsToShow[index].photo != null)
                          ? Image.network(
                              clientsToShow[index].photo.toString())
                          : Image.asset(defaultProfileImage),
                    ),
                  );
  }

  Widget setupAlertDialoadContainer(BuildContext context, ClientData client) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Are you sure you want to delete ${client.firstName}, ${client.lastName} client?',
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
}
