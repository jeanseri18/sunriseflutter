import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/features/auth/login/cubit/login_cubit_cubit.dart';
import 'package:sunrise_hosting/features/auth/login/login_page.dart';
import 'package:sunrise_hosting/features/auth/register/register_page.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/herbergement/hebergement_post_list/hebergement_post_list_page.dart';
import 'package:sunrise_hosting/features/order/order_page.dart';
import 'package:sunrise_hosting/features/paiment/paiment_history/paiment_history_page.dart';
import 'package:sunrise_hosting/features/profile/profile_page.dart';

import 'package:sunrise_hosting/widget/assistance_chat_widget.dart';
import 'package:sunrise_hosting/widget/legal_notice_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [],
      ),
      //   title: const Text(
      //     'Mon espace',
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontWeight: FontWeight.bold,
      //         fontFamily: 'Poppins',
      //         fontSize: 30),
      //     textAlign: TextAlign.center,
      //   ),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                    color: Colors.black,
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                          trailing: Icon(Icons.navigate_next),
                          title: const Text(
                            'Espace Professionel, \n Poster votre bien ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                widget.isexpireToken
                    ? buildTokenNoValidColmun()
                    : buildTokenValidColmun(),
              ],
            )),
      ),
    );
  }

  Widget buildTokenValidColmun() {
    return Column(children: [
      // _buildListTileItem(
      //   Icons.favorite,
      //   'Mes favoris',
      //   Container(),
      // ),
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildListTileItem(
          Icons.edit,
          'Information personnelle',
          ProfilePage(isexpireToken: widget.isexpireToken),
        ),
        _buildListTileItem(
          Icons.password_sharp,
          'Paiement',
          PaimentHistoryPage(
            isexpireToken: widget.isexpireToken,
          ),
        )
      ])),

      Divider(),
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildListTileItem(
          Icons.price_change,
          'Mes annonces',
          HebegementPostListPage(
            isexpireToken: widget.isexpireToken,
            isSettingPageBack: true,
          ),
        ),
        _buildListTileItem(
          Icons.calendar_month,
          'Mes commandes',
          OrderPage(
            isexpireToken: widget.isexpireToken,
          ),
        )
      ])),

      Divider(),
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildListTileItem(
          Icons.price_change,
          'A propos ',
          LegalNoticePage(
            isexpireToken: widget.isexpireToken,
          ),
        ),
        _buildListTileItem(
          Icons.calendar_month,
          'Condition general',
          LegalNoticePage(
            isexpireToken: widget.isexpireToken,
          ),
        ),
        _buildListTileItem(
          Icons.headset_mic_rounded,
          'Assistance clientele',
          AssistanceChatWidget(
            isexpireToken: widget.isexpireToken,
          ),
        )
      ])),
      Divider(),
      ListTile(
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // Affiche le modal de confirmation de déconnexion
                return AlertDialog(
                  title: Text('Confirmation de déconnexion'),
                  content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Ferme le modal
                      },
                      child: Text('Annuler'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        context.read<LoginCubit>().logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnBoardPage()),
                            (route) => false);
                      },
                      child: const Text('Déconnexion'),
                    ),
                  ],
                );
              },
            );
          },
          title: Text('Deconnexion'),
          leading: const Icon(
            Icons.logout,
            color: Colors.black,
          )),
      const SizedBox(
        height: 100,
      ),
      // BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      //   log(state.toString());
      //   if (state is LoginOtpStateLogout) {
      //     return const Center(child: LoaderWidget());
      //   }
      //   return Container();
      // }),
    ]);
  }

  Widget _buildListTileItem(IconData icon, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
              leading: Icon(
                icon,
                color: Colors.black,
              ),
              trailing: const Icon(
                Icons.navigate_next_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          // Divider()
        ],
      ),
    );
  }

  Widget _buildBtnlogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: ColorName.orangeTwins,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: TextButton(
            onPressed: () async {
              // context.read<LoginCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/OnBoardPage', (route) => false);
            },
            child: const Center(
              child: Text(
                'Deconnexion',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          leading: const Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTokenNoValidColmun() {
    return Column(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildListTileItem(
                Icons.price_change,
                'Connexion',
                LoginPage(
                  isSettingPageBack: true,
                  isexpireToken: widget.isexpireToken,
                ),
              ),
              _buildListTileItem(
                Icons.calendar_month,
                'Inscription',
                RegisterPage(
                  isSettingPageBack: true,
                  isexpireToken: widget.isexpireToken,
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _buildListTileItem(
            Icons.price_change,
            'A propos ',
            LegalNoticePage(
              isexpireToken: widget.isexpireToken,
            ),
          ),
          _buildListTileItem(
            Icons.calendar_month,
            'Condition general',
            LegalNoticePage(
              isexpireToken: widget.isexpireToken,
            ),
          ),
          _buildListTileItem(
            Icons.headset_mic_rounded,
            'Assistance clientele',
            AssistanceChatWidget(
              isexpireToken: widget.isexpireToken,
            ),
          )
        ])),
      ],
    );
  }
}
