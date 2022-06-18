import 'package:flutter/material.dart';
///Page that shows no results  were found.
class SearchNoResultsFound extends StatelessWidget {
  ///Constructor
  const SearchNoResultsFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          'No results found',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
