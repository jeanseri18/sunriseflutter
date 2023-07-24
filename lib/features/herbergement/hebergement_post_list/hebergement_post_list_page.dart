import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_detail/hebergement_detail_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_post/hebergement_post_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_search/herbergement_search_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class HebegementPostListPage extends StatefulWidget {
  const HebegementPostListPage(
      {super.key,
      required this.isexpireToken,
      required this.isSettingPageBack});
  final bool isexpireToken;

  final bool isSettingPageBack;

  @override
  State<HebegementPostListPage> createState() => _HebegementPostListPageState();
}

class _HebegementPostListPageState extends State<HebegementPostListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.orangeTwins,
          ),
          onPressed: () {
            widget.isSettingPageBack
                ? Navigator.push(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => HomeParentPage(
                        index: 3,
                        isexpireToken: widget.isexpireToken,
                      ),
                    ))
                : Navigator.pop(
                    context,
                  );
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HebergementPostPage()),
                );
              },
              child: Row(
                children: [Icon(Icons.add), Text('ajouter')],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              _buildHebergementItem(context),
              _buildHebergementItem(context)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildHebergementItem(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.images.test.path,
                    )),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: 200,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(Icons.edit),
            title: Text(
              'Residence Meuble',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Text('Abidjan, youpougon'),
          Text(
            '10.000 CFa',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
