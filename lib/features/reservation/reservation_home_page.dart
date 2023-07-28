import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';

import '../../data/model/reservation_list_model.dart';

class ReservationHomePage extends StatefulWidget {
  const ReservationHomePage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;
  @override
  State<ReservationHomePage> createState() => _ReservationHomePageState();
}

class _ReservationHomePageState extends State<ReservationHomePage> {
  @override
  void initState() {
    context.read<ReservationCubit>().getReservationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Mes Reservations',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _buildReservationListView(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationListView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 168,
      child: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          print(state);
          if (state is ReservationStateError) {}
          if (state is ReservationStateLoading) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          enabled: true,
                          child: SizedBox(
                            height: 200,
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 239, 239, 239),
                                        // color: Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: 180,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Assets.images.test.path),
                                                  fit: BoxFit.cover),
                                              // color: Color.fromARGB(255, 255, 255, 255),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 10,
                                                  color: Colors.grey[100],
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 10,
                                                  color: Colors.grey[100],
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 10,
                                                  color: Colors.grey[100],
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 10,
                                                  color: Colors.grey[100],
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 10,
                                                  color: Colors.grey[100],
                                                ),
                                                SizedBox(height: 10),
                                                // Text(
                                                //   'Paiement en espace',
                                                //   style: TextStyle(color: Colors.black, fontSize: 12),
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Wrap(
                                                  spacing: 0.7,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            'Payer',
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          )),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text('Annuler',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11))),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Divider(),
                                ],
                              ),
                            ),
                          ));
                    }));
          }
          if (state is ReservationStateLoaded) {
            inspect(state.response.data!.length);
            return ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.response.data!.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    child: _buildReservationItem(
                        context, state.response.data![index]));
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildReservationItem(BuildContext context, Data model) {
    var image = "";

// Utilisez imageUrl pour afficher l'image dans votre code

    return model.isOwner == false
        ? SizedBox(
            height: 200,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return ReservationDetailPage(
                          // model: model,
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
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 239, 239),
                        // color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 180,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.images.test.path),
                                  fit: BoxFit.cover),
                              // color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Reservation',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  model.userPropio?.name ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  model.hebergement?.titre ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  'Pour  ${model.dateDebut}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  'Au ${model.dateFin}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                // Text(
                                //   'Paiement en espace',
                                //   style: TextStyle(color: Colors.black, fontSize: 12),
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  spacing: 0.7,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Payer',
                                            style: TextStyle(fontSize: 11),
                                          )),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Annuler',
                                              style: TextStyle(fontSize: 11))),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider(),
                ],
              ),
            ),
          )
        : Container();
  }
}

class ReservationDetailPage extends StatefulWidget {
  const ReservationDetailPage({super.key});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
