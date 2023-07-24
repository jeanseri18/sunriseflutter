import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/data/model/user_model.dart';
import 'package:sunrise_hosting/features/auth/login/cubit/login_cubit_cubit.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:sunrise_hosting/features/password/passwordForgetPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(
      {super.key,
      required this.isexpireToken,
      required this.isSettingPageBack});
  final bool isexpireToken;

  final bool isSettingPageBack;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  var invisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              // Center(
              //   child: Image.asset(
              //     // Assets.images.appstore.path,
              //     width: 150,
              //   ),
              // )
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorName.orangeTwins,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => const OnBoardPage(),
                    ),
                    (route) => true);
              },
            ),
          ),
          body: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Center(
                    //   child: Image.asset(
                    //     Assets.images.iconpropertyform.path,
                    //     width: 200,
                    //   ),
                    // ),
                    const Text(
                      'Connectez-vous à votre compte',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                    _buildEmailAndPasswordForm(context),
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Container(
                              height: 1,
                              color: ColorName.btnGray,
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                            Text('Ou'),
                            Container(
                              height: 1,
                              color: ColorName.btnGray,
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        )),
                    _buildBtnRegister(context)
                    // _buildBtnActiveTelForm(context)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // Widget _buildBtnActiveTelForm(BuildContext context) {
  //   return SizedBox(
  //     height: 50,
  //     width: MediaQuery.of(context).size.width,
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(0.0),
  //             side: const BorderSide(color: ColorName.orangeTwins),
  //           ),
  //         ),
  //       ),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const LoginPageViaTel()),
  //         );
  //       },
  //       child: const Text(
  //         'Uitiliser un code OTP',
  //         style: TextStyle(
  //             fontSize: 16,
  //             fontFamily: 'Poppins',
  //             color: ColorName.orangeTwins),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEmailAndPasswordForm(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Email ou numéro de téléphone (avec indicatif)',
            style: TextStyle(
                fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 55,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: '',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut etre vide';
                }

                return null;
              },
              controller: _emailController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Mot de passe',
            style: TextStyle(
                fontSize: 13, fontFamily: 'Poppins', color: Colors.black),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 55,
            child: TextFormField(
              obscureText: invisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        invisible ? invisible = false : invisible = true;
                      });
                    }),
                hintText: '',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut etre vide';
                }

                return null;
              },
              controller: _passwordController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return const PasswordForgetPage();
                },
              ));
            },
            child: const Text(
              'Mot de passe oublié',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<LoginCubit, LoginCubitState>(
            buildWhen: (_, state) => state is! LoginStateError,
            listener: (context, state) {
              if (state is LoginStateError) {
                log('error..........${state.error}');
                final snackBar = SnackBar(
                  content: Text(state.error == null
                      ? 'verifiez votre connexion internet'
                      : state.error),
                  backgroundColor: (Colors.black),
                  action: SnackBarAction(
                    label: 'fermer',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is LoginStateLoaded) {
                // var userInfo = UserModel.fromJson(state.response.data);

                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => HomeParentPage(
                              index: 0,
                              isexpireToken: false,
                            ),
                        maintainState: false),
                    (route) => false);
              }
            },
            builder: (context, state) {
              log(state.toString());
              if (state is LoginStateLoading) {
                // return const Center(child: LoaderWidget());
              }
              if (state is LoginStateError) {
                log('logged error..........${state.error}');
              }
              if (state is LoginStateLoaded) {
                log('logged ok..........${state.response.data}');
              }

              return Container();
            },
          ),
          _buildBtnLogin(context),
        ]);
  }

  Widget _buildBtnLogin(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context
                .read<LoginCubit>()
                .loginByMail(_emailController.text, _passwordController.text);
          }
        },
        child: const Text(
          'Se connecter',
          style: TextStyle(
              fontSize: 17, fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBtnRegister(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          // if (_formKey.currentState!.validate()) {
          //   context
          //       .read<LoginCubit>()
          //       .loginByMail(_emailController.text, _passwordController.text);
          // }
        },
        child: const Text(
          'Creer un compte',
          style: TextStyle(
              fontSize: 17, fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
    );
  }
}
