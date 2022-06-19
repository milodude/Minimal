import 'package:flutter/material.dart';

import '../../domain/entities/client.dart';
import '../widgets/search_no_results_found.dart';

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
                      if(value == 'delete'){

                      }
                    },
                  ),
                ),
              );
            });
  }
}
