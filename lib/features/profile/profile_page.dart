import 'package:flutter/material.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.isexpireToken});

  final bool isexpireToken;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  var invisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
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
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Information personnelle',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                  _buildEmailAndPasswordForm(context),

                  // _buildBtnActiveTelForm(context)
                ],
              ),
            ),
          ),
        ));
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
            'Nom prenom',
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
                prefixIcon: const Icon(Icons.person_2_outlined),
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
            'Telephone',
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
                prefixIcon: const Icon(Icons.person_2_outlined),
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
              keyboardType: TextInputType.datetime,
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
              controller: TextEditingController(),
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
          const SizedBox(
            height: 20,
          ),
          _buildBtnLogin(context),
        ]);
  }

  Widget _buildBtnLogin(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          'Modifier',
          style: TextStyle(
              fontSize: 17, fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
    );
  }
}
