import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/notification/notification_item_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Boite de reception',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              isScrollable: false,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Message'),
                Tab(text: 'Notification'),
                Tab(text: ''),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  NotificationItemPage(),
                  NotificationItemPage(),
                  NotificationItemPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
