import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WPConfig.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Contact',
          style: TextStyle(
              fontFamily: 'Avenir', fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}
