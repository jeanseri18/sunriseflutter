import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/features/auth/register/cubit/registercubit_cubit.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:sunrise_hosting/features/password/passwordForgetPage.dart';
import 'package:flutter_intl/flutter_intl.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_hosting/widget/loader_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(
      {super.key,
      required this.isexpireToken,
      required this.isSettingPageBack});
  final bool isexpireToken;

  final bool isSettingPageBack;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _villeController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _passwordController = TextEditingController();
  var invisible = true;
  var _selectedDateFin;
  Future<void> _selectDateFin() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(
          days:
              365)), // Permet de sélectionner une date jusqu'à un an à l'avance
    );
    if (picked != null && picked != _selectedDateFin) {
      setState(() {
        _selectedDateFin = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Creez votre compte',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 25),
              textAlign: TextAlign.left,
            ),
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
            'Nom et prenoms',
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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: '',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut etre vide';
                }

                return null;
              },
              controller: _nameController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Numero de telephone',
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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: '',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut etre vide';
                }

                return null;
              },
              controller: _phoneController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Date de naissance',
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
              onTap: _selectDateFin,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.date_range),
                hintText: '',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut etre vide';
                }

                return null;
              },
              controller: _dateController,
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // SizedBox(
          //   height: 55,
          //   child: TextFormField(
          //     decoration: const InputDecoration(
          //       prefixIcon: Icon(Icons.person_2_outlined),
          //       hintText: '',
          //     ),
          //     validator: (value) {
          //       if (value!.isEmpty) {
          //         return 'Ce champ ne peut etre vide';
          //       }

          //       return null;
          //     },
          //     controller: _phoneController,
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Ville',
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
              keyboardType: TextInputType.text,
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
              controller: _villeController,
            ),
          ),
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
          BlocConsumer<Registercubit, RegistercubitState>(
            listener: (context, state) {
              if (state is RegisterStateError) {
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
              if (state is RegisterStateLoaded) {
                log('ok');
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => HomeParentPage(
                              isexpireToken: false,
                              index: 0,
                            )),
                    (route) => false);
              }
            },
            // buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is RegisterStateLoading) {
                return const Center(child: LoaderWidget());
              }
              if (state is RegisterStateLoaded) {
                log('message :${state.response.data}');
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
          if (_nameController.text.isNotEmpty &&
              _dateController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty) {
            // if (_formKey.currentState!.validate()) {
            var email = '';
            if (_emailController.text.isNotEmpty) {
              email = _emailController.text;
            }
            context.read<Registercubit>().registerFetch(
                  _nameController.text,
                  _phoneController.text,
                  _dateController.text,
                  'client',
                  _passwordController.text,
                  _villeController.text,
                  _emailController.text,
                  _passwordController.text,
                );
          } else {
            final snackBar = SnackBar(
              content: Text(
                  'Veuillez remplir correctement les champs du formulaire'),
              backgroundColor: (Colors.black),
              action: SnackBarAction(
                label: 'fermer',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Text(
          'Valider',
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
          'Se connectez',
          style: TextStyle(
              fontSize: 17, fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
    );
  }
}
