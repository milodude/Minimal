import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
                      'Cancel',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 18,
                        color: Color.fromRGBO(8, 8, 22, 0.38),
                      ),
                    );
  }
}