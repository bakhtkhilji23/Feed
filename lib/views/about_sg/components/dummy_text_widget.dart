import 'package:flutter/material.dart';

class DummyTextWidget extends StatelessWidget {
  const DummyTextWidget({
    Key? key,
    this.text = '',
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 25, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
