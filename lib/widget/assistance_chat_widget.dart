import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';

class AssistanceChatWidget extends StatefulWidget {
  const AssistanceChatWidget({super.key, required this.isexpireToken});

  final bool isexpireToken;

  @override
  State<AssistanceChatWidget> createState() => _AssistanceChatWidgetState();
}

class _AssistanceChatWidgetState extends State<AssistanceChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Assitance clientelle'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => HomeParentPage(
                      index: 4,
                      isexpireToken: widget.isexpireToken,
                    ),
                  ));
            },
          ),
        ),
        body: const SingleChildScrollView());
  }
}
