import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/presentation/bloc/client/client_bloc.dart';

import '../widgets/search_no_results_found.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);
  static const String routeName = '/clients';

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  Widget _getBody() {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  top: 200,
                  left: MediaQuery.of(context).size.width - 140,
                  child: Container(
                    width: 200,
                    height: 209,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(228, 243, 83, 1)),
                  )),
              Positioned(
                  top: -30,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(228, 243, 83, 0.33)),
                  )),
              Positioned(
                top: 500,
                left: 220,
                child: Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 305,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(228, 243, 83, 0.33)),
                ),
              ),
              Positioned(
                  top: 550,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(228, 243, 83, 0.33)),
                  )),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.transparent,
                ),
              )),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: PlayAnimation<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 1),
                      builder: (context, child, value) {
                        return Opacity(
                          opacity: value,
                          child: const Text(
                            'minimal',
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120.0, left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CLIENTS',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: SizedBox(
                                width: 117,
                                height: 36,
                                child: TextFormField(
                                  controller: inputController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Client name..',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    labelText: 'Search...',
                                    prefixIcon: const Icon(Icons.search_sharp),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(68),
                                    ),
                                  ),
                                  onChanged: (String text) {
                                    //_onChanged(text);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  //Testing purposes
                                },
                                child: const Text(
                                  'ADD NEW',
                                  style: TextStyle(letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Clients list
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0, right: 32),
                        child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height - 170 - 200,
                            child: _getClientsListview()),
                      ),

                      ///Add more button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: SizedBox(
                              width: 296,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  var clientBloc = context.read<ClientBloc>();
                                  BlocProvider.of<ClientBloc>(context).add(
                                      ShowMoreInClientsList(
                                          clientsList:
                                              clientBloc.state.clientsData,
                                          clientsToShowList: clientBloc
                                              .state.clientDataToShow));
                                },
                                child: const Text(
                                  'LOAD MORE',
                                  style: TextStyle(letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getClientsListview() {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state is Initial) {
          ReadContext(context).read<ClientBloc>().add(const GetClients());
        } else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return ExpandedShowsGridView(
            clientsToShow: state.clientsToShow,
          );
        } else if (state is Error) {
          return const Center(
              child: Text(
                  'Error while trying to retrieve data from the backend'));
        }
        return const Text('Unknown error occurred');
        // We're going to also check for the other states
      },
    );
  }
}

///Widget that shows you a list of shows
class ExpandedShowsGridView extends StatelessWidget {
  ///Constructor that takes  a list of shows.
  final List<ClientData> clientsToShow;

  const ExpandedShowsGridView({
    Key? key,
    required this.clientsToShow,
  }) : super(key: key);

  ///Parameter. A list of shows.
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
                  trailing: const Icon(Icons.more_vert),
                ),
              );
            });
  }
}
