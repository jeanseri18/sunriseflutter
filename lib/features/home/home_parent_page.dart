import 'package:flutter/material.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/home/home_error_auth_redirection_page.dart';
import 'package:sunrise_hosting/features/home/home_page.dart';
import 'package:sunrise_hosting/features/house_place/house_place.dart';
import 'package:sunrise_hosting/features/notification/notification_page.dart';
import 'package:sunrise_hosting/features/setting/setting_page.dart';

class HomeParentPage extends StatefulWidget {
  const HomeParentPage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;
  @override
  State<HomeParentPage> createState() => _HomeParentPageState();
}

class _HomeParentPageState extends State<HomeParentPage> {
  int _selectedIndex = 0;
  // void verify() async {
  //   var result = await AuthProvider().isTokenValid();
  //   if (result == true) {
  //   } else {
  //     await refreshingViaLogin();
  //   }
  // }

  // Future<void> refreshingViaLogin() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var type = prefs.getString('type');
  //   if (type == 'phone') {
  //     var number = prefs.getString('phoneOrEmail');

  //     var result = await AuthProvider().loginViaOtp(number!);
  //     log('login telephone$result');
  //     Navigator.pushAndRemoveUntil(
  //         (context),
  //         MaterialPageRoute(
  //           builder: (context) => SmsVerificationPage(
  //             number: number,
  //             sendIsActiv: false,
  //           ),
  //         ),
  //         (route) => true);
  //   } else {
  //     var email = prefs.getString('phoneOrEmail');

  //     var result = await AuthProvider().loginViaEmail(email!, type!);
  //     log('login email$result');

  //     if (result.data != null) {
  //       var userInfo = UserModel.fromJson(result.data);
  //       if (userInfo.status! == 'inactif') {
  //         log('inactif');
  //         // ignore: use_build_context_synchronously
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   SmsVerificationPage(number: userInfo.phone!)),
  //         );
  //       }
  //     } else {
  //       log('error');
  //     }
  //   }
  // }

  @override
  void initState() {
    // verify();
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _page = <Widget>[
      HomePage(
        index: 0,
        isexpireToken: widget.isexpireToken,
      ),
      HousePlcaePage(
        index: 1,
        isexpireToken: widget.isexpireToken,
      ),
      NotificationPage(
        isexpireToken: widget.isexpireToken,
        index: 1,
      ),
      SettingPage(
        isexpireToken: false,
        index: 3,
      )
    ];
    List<Widget> _pageoffine = <Widget>[
      HomePage(
        index: 0,
        isexpireToken: widget.isexpireToken,
      ),
      HousePlcaePage(
        isexpireToken: widget.isexpireToken,
        index: 1,
      ),
      NotificationPage(isexpireToken: widget.isexpireToken, index: 2),
      SettingPage(
        isexpireToken: true,
        index: 3,
      )
    ];

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          // appBar: _buildAppBar(context),
          bottomNavigationBar: BottomNavigationBar(
            // elevation: 5,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: ColorName.textGray,
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            selectedLabelStyle: const TextStyle(fontSize: 12),
            selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                // verify();
                _selectedIndex = value;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 32,
                ),
                label: 'Annonces',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: 32,
                ),
                label: 'explorez',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.search,
              //     size: 32,
              //   ),
              //   label: 'RECHERCHE',
              // ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.messenger_outline_outlined,
                  size: 32,
                ),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 32,
                  ),
                  label: 'Profile'),
            ],
          ),
          body: widget.isexpireToken
              ? _pageoffine.elementAt(_selectedIndex)
              : _page.elementAt(_selectedIndex),
        ));
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    // title: SvgPicture.asset(
    //   Assets.images.logoWhite.path,
    //   fit: BoxFit.fitHeight,
    // ),
    actions: const [
      // _buildTicketButton(context),
      // const BalanceToogle(),
    ],
  );
}
