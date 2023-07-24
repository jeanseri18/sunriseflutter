import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:flutter/material.dart';

class LegalNoticePage extends StatefulWidget {
  const LegalNoticePage({super.key, required this.isexpireToken});

  final bool isexpireToken;
  @override
  State<LegalNoticePage> createState() => _LegalNoticePageState();
}

class _LegalNoticePageState extends State<LegalNoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Condition general'),
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
