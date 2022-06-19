import 'dart:io';

import 'package:coda_test/features/clients/presentation/bloc/single_client/single_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/images.dart';
import '../../domain/entities/client.dart';

class AddClientModal extends StatefulWidget {
  const AddClientModal({
    Key? key,
  }) : super(key: key);

  @override
  State<AddClientModal> createState() => _AddClientModalState();
}

class _AddClientModalState extends State<AddClientModal> {
  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final mailInputController = TextEditingController();

  File? image;

  Future pickImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Add new client',
                      style: TextStyle(fontSize: 27),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async => pickImage(),
                      child: image != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 76,
                            )
                          : const CircleAvatar(
                              backgroundImage: AssetImage(uploadImage),
                              radius: 76,
                            ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 295,
                      height: 100,
                      child: TextField(
                        controller: firstNameInputController,
                        decoration: const InputDecoration(
                          labelText: 'First Name*',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 295,
                      height: 100,
                      child: TextField(
                        controller: lastNameInputController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name*',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 295,
                      height: 100,
                      child: TextField(
                        controller: mailInputController,
                        decoration: const InputDecoration(
                          labelText: 'Email address*',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 18,
                        color: Color.fromRGBO(8, 8, 22, 0.38),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      fixedSize: const Size(159, 40),
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      ClientData newClient = ClientData(
                        firstName: firstNameInputController.text,
                        lastName: lastNameInputController.text,
                        email: mailInputController.text,
                      );
                      BlocProvider.of<SingleClientBloc>(context).add(AddSingleClient(clientToAdd: newClient));
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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