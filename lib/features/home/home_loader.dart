import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sunrise_hosting/data/model/apireponse.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';
import 'package:sunrise_hosting/features/auth/login/login_page.dart';
import 'package:sunrise_hosting/features/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';

class HomeLoaderPage extends StatefulWidget {
  const HomeLoaderPage({Key? key}) : super(key: key);

  @override
  State<HomeLoaderPage> createState() => _HomeLoaderPageState();
}

class _HomeLoaderPageState extends State<HomeLoaderPage> {
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

    if (tokenIsValid) {
      // Token is valid, redirect to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeParentPage(
                  index: 0,
                  isexpireToken: false,
                )),
      );
    } else {
      WidgetsFlutterBinding.ensureInitialized();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('phoneOrEmail');
      var password = prefs.getString('password');

      // Replace with actual user password
      var response = await AuthProvider().loginUser(email!, password!);
      if (response.status!) {
        // Login successful, redirect to HomePage
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeParentPage(
                    index: 0,
                    isexpireToken: false,
                  )),
        );
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
    super.initState();
    Timer(const Duration(seconds: 5), () {
      refreshingViaLogin();
    });
    // isTokenValid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleLoader(
          color: Colors.amber,
          size: 200,
        ), // Show a loading indicator while checking login status
      ),
    );
  }
}

class CircleLoader extends StatefulWidget {
  final double size;
  final Color color;

  const CircleLoader({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  _CircleLoaderState createState() => _CircleLoaderState();
}

class _CircleLoaderState extends State<CircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.size,
          height: widget.size,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Image.asset(
              Assets.images.logo.path,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
