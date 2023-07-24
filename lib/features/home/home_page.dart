import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/cubit/hebergement_cubit.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_detail/hebergement_detail_page.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_search/herbergement_search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    context.read<HebergementCubit>().getHebergementList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HebergementSearchPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(161, 158, 158, 158)
                            .withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        // offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Commencez le voyage ?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Cliquez ici pour faire une recherche',
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 168,
              child: DefaultTabController(
                length: 4,
                child: SafeArea(
                  child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        toolbarHeight: 10,
                        bottom: TabBar(
                          onTap: (int index) {
                            setState(() {
                              selectedTabIndex = index;
                            });
                          },
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(3),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black,
                          ),
                          isScrollable: true,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                          tabs: const [
                            Tab(text: 'Tous'),
                            Tab(text: 'Hôtel'),
                            Tab(text: 'Residence Meublée'),
                            Tab(text: 'Locations'),
                          ],
                        ),
                        elevation: 0,
                      ),
                      body: TabBarView(
                          // physics: BouncingScrollPhysics(),
                          // dragStartBehavior: DragStartBehavior.down,
                          children: [
                            _buildHebergementListView(context),
                            _buildHebergementListView(context),
                            _buildHebergementListView(context),
                            _buildHebergementListView(context),
                          ])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHebergementListView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 168,
      child: BlocBuilder<HebergementCubit, HebergementState>(
        builder: (context, state) {
          if (state is HebergementStateError) {
            return Text(state.error);
          }
          if (state is HebergementStateLoading) {}
          if (state is HebergementStateLoaded) {
            inspect(state.response.data!.length);
            return ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.response.data!.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    child: _buildHebergementItem(
                        context, state.response.data![index]));
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHebergementItem(BuildContext context, Data model) {
    var image = model.images;

// Utilisez imageUrl pour afficher l'image dans votre code

    return SizedBox(
      height: 310,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return hebergementDetailPage(
                  model: model,
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Colors.amber,
                image: image?.isNotEmpty ?? true
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'http://sunrise-housing.net/storage/' +
                                image!.first.fileUrl!),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.images.test.path),
                      ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              height: 220,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.titre ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(model.commune ?? '' + ', ' + model.ville!),
            Text(
              model.prix.toString() + ' FCFA',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
