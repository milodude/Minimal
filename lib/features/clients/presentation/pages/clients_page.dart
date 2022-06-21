import 'dart:ui';

import 'package:coda_test/features/clients/presentation/pages/base_clients_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

import '../../../../core/constants/text.dart';
import '../../../../core/shared_widgets/yellow_bubble.dart';
import '../bloc/clients/client_bloc.dart';
import 'base_add_edit_client_modal.dart';

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
    return _getBody(context);
  }

  Widget _getBody(BuildContext context) {
    final screenWidth =  MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                YellowBubble(
                    context: context,
                    width: 200,
                    heigth: 209,
                    topPosition: 200,
                    leftPosition: MediaQuery.of(context).size.width - 190),
                YellowBubble(
                    context: context,
                    width: 200,
                    heigth: 200,
                    topPosition: -100,
                    leftPosition: -10),
                YellowBubble(
                    context: context,
                    width: MediaQuery.of(context).size.width - 90,
                    heigth: 305,
                    topPosition: 550,
                    leftPosition: MediaQuery.of(context).size.width - 190),
                YellowBubble(
                  context: context,
                  width: 200,
                  heigth: 200,
                  topPosition: 550,
                  leftPosition: -100,
                ),
                Positioned.fill(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight - screenHeight * 0.95),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: PlayAnimation<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(seconds: 1),
                        builder: (context, child, value) {
                          return Opacity(
                            opacity: value,
                            child: const Text(
                              appName,
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
                    padding: EdgeInsets.only(top: screenHeight - screenHeight * 0.85, left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          clientsTitle,
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
                                flex: 6,
                                child: SizedBox(
                                  height: 36,
                                  child: TextFormField(
                                    controller: inputController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: searchBarHintText,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      labelText: searchBarLabel,
                                      prefixIcon:
                                          const Icon(Icons.search_sharp),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(68),
                                      ),
                                    ),
                                    onChanged: (String inputText) {
                                      var clientBloc = context.read<ClientBloc>();
                                      if (inputText.isNotEmpty) {
                                        clientBloc.add(SearchClient(name: inputText));
                                      }else{
                                        clientBloc.add(const GetClients());
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                flex: 4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    showGeneralDialog(
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
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return SafeArea(
                                          child: Material(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                color: Colors.white,
                                                child:
                                                    const BaseAddEditClientModal(
                                                  title: 'Add new client',
                                                )),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    buttonAddNewText,
                                    style: TextStyle(letterSpacing: 0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //*Clients list
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right:30.0),
                                child: SizedBox(
                                  height: screenHeight - screenHeight * 0.47,
                                  child: const BaseClientsGridView(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //*Load more button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32, right: 15),
                              child: SizedBox(
                                width: screenWidth - screenWidth * 0.24,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    var clientBloc = context.read<ClientBloc>();
                                    clientBloc.add(ShowMoreInClientsList(
                                        clientsList:
                                            clientBloc.state.clientsData,
                                        clientsToShowList:
                                            clientBloc.state.clientDataToShow));
                                  },
                                  child: const Text(
                                    buttonLoadMoreText,
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
      ),
    );
  }
}
