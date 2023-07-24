import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class PaimentHistoryPage extends StatefulWidget {
  const PaimentHistoryPage({super.key, required this.isexpireToken});

  final bool isexpireToken;
  @override
  State<PaimentHistoryPage> createState() => _PaimentHistoryPageState();
}

class _PaimentHistoryPageState extends State<PaimentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique de paiement'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.orangeTwins,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
              _buildPaiment(),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildPaiment() {
    return ListTile(
      title: Text('Payement en espece'),
      subtitle: Text('le 14 janvier 2023'),
      trailing: Text('\$25.000'),
    );
  }
}
