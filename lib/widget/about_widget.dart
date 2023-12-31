import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key, required this.isexpireToken});

  final bool isexpireToken;

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('A propos'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => HomeParentPage(
                      index: 3,
                      isexpireToken: widget.isexpireToken,
                    ),
                  ));
            },
          ),
        ),
        body: const SingleChildScrollView());
  }
}
