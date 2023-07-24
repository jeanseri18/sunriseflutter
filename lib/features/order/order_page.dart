import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/data/model/reservation_list_model.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.isexpireToken});

  final bool isexpireToken;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
          'Commande',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
            return Center(
              child: CircularProgressIndicator(),
            );
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

    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
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
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            model.hebergement?.titre ?? '',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            'Pour  ${model.dateDebut}',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            'Au ${model.dateFin}',
                            style: TextStyle(color: Colors.black, fontSize: 12),
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
                              if (model.isOwner == true)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Confirmer',
                                        style: TextStyle(fontSize: 11),
                                      )),
                                ),
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
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
    );
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
