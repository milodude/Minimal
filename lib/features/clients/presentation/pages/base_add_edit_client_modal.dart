import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:coda_test/features/clients/presentation/bloc/clients/client_bloc.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/shared_widgets/cancel_button.dart';
import '../../domain/entities/client.dart';

class BaseAddEditClientModal extends StatefulWidget {
  final String title;
  final ClientData? client;

  const BaseAddEditClientModal({
    Key? key,
    required this.title,
    this.client,
  }) : super(key: key);

  @override
  State<BaseAddEditClientModal> createState() => _BAddClientModalState();
}

class _BAddClientModalState extends State<BaseAddEditClientModal> {
  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final mailInputController = TextEditingController();

  File? image;
  final GlobalKey<FormState> _modalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      firstNameInputController.text = widget.client!.firstName.toString();
      lastNameInputController.text = widget.client!.lastName.toString();
      mailInputController.text = widget.client!.email.toString();
    }
  }

  Future pickImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getTitle(),
              ],
            ),
            SizedBox(
              height: isKeyBoardOpen ? 0 : screenHeight - screenHeight * 0.94,
            ),
            _getPhoto(isKeyBoardOpen),
            SizedBox(
              height: screenHeight - screenHeight * 0.94,
            ),
            _getForm(),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getCancelButton(context),
                  _getSaveButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _getSaveButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        fixedSize: const Size(159, 40),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (!_modalFormKey.currentState!.validate()) return;
        final clientBloc = context.read<ClientBloc>();
        ClientData newClient = ClientData(
          id: widget.client == null ? 0 : widget.client!.id,
          firstName: firstNameInputController.text,
          lastName: lastNameInputController.text,
          email: mailInputController.text,
        );
        if (widget.client != null) {
          clientBloc.add(EditClient(clientToEdit: newClient));
        } else {
          clientBloc.add(AddClient(clientToAdd: newClient));
        }
        clientBloc.add(const GetClients());
        Navigator.of(context).pop();
      },
      child: const Text(
        'SAVE',
        style: TextStyle(letterSpacing: 0.5),
      ),
    );
  }

  GestureDetector _getCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const CancelButton(),
    );
  }

  Form _getForm() {
    return Form(
      key: _modalFormKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 295,
              height: 100,
              child: TextFormField(
                controller: firstNameInputController,
                decoration: const InputDecoration(
                  labelText: 'First Name*',
                ),
                validator: (String? name) {
                  if (name == null || name.isEmpty) {
                    return 'You must add a firstname';
                  }
                  return null;
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 295,
              height: 100,
              child: TextFormField(
                controller: lastNameInputController,
                decoration: const InputDecoration(
                  labelText: 'Last Name*',
                ),
                validator: (String? lastName) {
                  if (lastName == null || lastName.isEmpty) {
                    return 'You must add a lastname';
                  }
                  return null;
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 295,
              height: 100,
              child: TextFormField(
                controller: mailInputController,
                decoration: const InputDecoration(
                  labelText: 'Email address*',
                ),
                validator: (String? email) {
                  if (email == null || email.isEmpty) {
                    return 'You must add an email';
                  }

                  if(!EmailValidator.validate(email)){
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility _getPhoto(bool isKeyBoardOpen) {
    return Visibility(
      visible: !isKeyBoardOpen,
      child: Padding(
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
    );
  }

  Padding _getTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 27),
      ),
    );
  }
}
