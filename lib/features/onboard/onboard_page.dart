import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/auth/login/login_page.dart';
import 'package:sunrise_hosting/features/auth/register/register_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            // decoration: const BoxDecoration(
            //     color: Colors.amber,
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/bg_onboard.png"),
            //       fit: BoxFit.cover,
            //     )),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Image.asset(
                    Assets.images.logo.path,
                    height: 170,
                    width: 170,
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     '    Assets.images.appstore.path,',
                  //     width: 180,
                  //   ),
                  // ),
                  const Text(
                    'Voyagez deviens facile',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.height,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: (() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(
                                isSettingPageBack: false,
                                isexpireToken: true,
                              ),
                              maintainState: false,
                            ),
                            (route) => true,
                          )),
                      child: const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.height,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: (() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(
                                isSettingPageBack: false,
                                isexpireToken: true,
                              ),
                              maintainState: false,
                            ),
                            (route) => true,
                          )),
                      child: const Text(
                        'cree un compte',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors
                              .amber, // Changed the text color to black for better visibility
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
      // bottomNavigationBar: ListTile(
      //     trailing: const Icon(Icons.navigate_next),
      //     title: TextButton(
      //         onPressed: () => Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const HomeParentPage(
      //                       isexpireToken: true,
      //                       index: 0,
      //                     ),
      //                 maintainState: false),
      //             (route) => true),
      //         child: const Text(' Commencez',
      //             style: TextStyle(
      //               fontSize: 15,
      //               color: Colors.black,
      //               fontWeight: FontWeight.w600,
      //             )))),
    );
  }
}
