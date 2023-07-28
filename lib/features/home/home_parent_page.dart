import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';
import 'package:sunrise_hosting/features/home/home_loader.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:sunrise_hosting/features/reservation/reservation_home_page.dart';
import 'package:sunrise_hosting/features/reservation/reservation_page.dart';
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
  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('token');

    if (encodedMap == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoardPage()),
      );
      // Token is not present, so it is not valid
      return false;
    }

    var decodedMap = json.decode(encodedMap);
    var response = AccessToken.fromJson(decodedMap);

    // Check if the token is expired
    if (response.expiresIn != null) {
      var expiresIn = DateTime.parse(response.expiresIn!.toString());
      if (expiresIn.isAfter(DateTime.now())) {
        // Token is still valid
        print('value');
        return true;
      }
    }

    // Token is either missing or expired
    return false;
  }

  Future refreshingViaLogin() async {
    bool tokenIsValid = await isTokenValid();

    if (!tokenIsValid) {
      print('object');
      // Token is valid, redirect to HomePage
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => HomeParentPage(
      //             index: 0,
      //             isexpireToken: false,
      //           )),
      // );
    } else {
      WidgetsFlutterBinding.ensureInitialized();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('phoneOrEmail');
      var password = prefs.getString('password');
      print(email);
      print(password);
      // Replace with actual user password
      var response = await AuthProvider().loginUser(email!, password!);
      inspect(response);
      if (response.status!) {
        // Login successful, redirect to HomePage
        // ignore: use_build_context_synchronously
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const HomeParentPage(
        //             index: 0,
        //             isexpireToken: false,
        //           )),
        // );
      } else {
        // Login failed, stay on LoginPage and show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.error!)),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardPage()),
        );
      }
    }
  }

  @override
  void initState() {
    // verify();
    refreshingViaLogin();

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
      ReservationHomePage(
        index: 1,
        isexpireToken: widget.isexpireToken,
      ),
      HousePlcaePage(
        index: 2,
        isexpireToken: widget.isexpireToken,
      ),
      NotificationPage(
        isexpireToken: widget.isexpireToken,
        index: 3,
      ),
      SettingPage(
        isexpireToken: false,
        index: 4,
      )
    ];
    List<Widget> _pageoffine = <Widget>[
      HomePage(
        index: 0,
        isexpireToken: widget.isexpireToken,
      ),
      ReservationHomePage(
        index: 1,
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
                refreshingViaLogin();

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
                  Icons.favorite,
                  size: 32,
                ),
                label: 'Reservation',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: 32,
                ),
                label: 'Explorez',
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
