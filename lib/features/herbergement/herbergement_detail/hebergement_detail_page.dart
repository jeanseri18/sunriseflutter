import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/features/notification/cubit/message_cubit.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';
import 'package:sunrise_hosting/features/reservation/reservation_form_page.dart';
import 'package:sunrise_hosting/gen/assets.gen.dart';

class hebergementDetailPage extends StatefulWidget {
  const hebergementDetailPage({super.key, required this.model});
  final Data model;
  @override
  State<hebergementDetailPage> createState() => _hebergementDetailPageState();
}

class _hebergementDetailPageState extends State<hebergementDetailPage> {
  bool wifiChecked = true;
  bool climatisationChecked = false;
  bool televisionChecked = false;
  bool cuisineChecked = true;

  GoogleMapController? mapController;
  final TextEditingController _textController = TextEditingController();
  var lat = 0.0;
  var lng = 0.0;
  LatLng newlatlang = LatLng(0.0, 0.0);
  @override
  void initState() {
    lat = double.parse(widget.model.lat!.toString());
    lng = double.parse(widget.model.long!.toString());

    newlatlang = LatLng(lat, lng);
    log(newlatlang.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail de l annonce'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: widget.model.images?.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(i.fileUrl!)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0))),
                      height: 250,
                    );
                    // Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //     decoration: BoxDecoration(color: Colors.amber),
                    //     child: Text(
                    //       'text $i',
                    //       style: TextStyle(fontSize: 16.0),
                    //     ));
                  },
                );
              }).toList(),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.amber,
            //       image: DecorationImage(
            //           fit: BoxFit.cover,
            //           image: AssetImage(
            //             Assets.images.test.path,
            //           )),
            //       borderRadius: const BorderRadius.all(Radius.circular(0))),
            //   height: 280,
            // ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.model.titre!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.description!,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Commodités',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Wi-Fi gratuit',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].wifi == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // wifiChecked = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Climatisation',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].clim == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // climatisationChecked = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'Télévision',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].tv == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // televisionChecked = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CheckboxListTile(
                              title: Text(
                                'gardien',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: widget.model.commodite?[0].gardien == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                setState(() {
                                  // cuisineChecked = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CheckboxListTile(
                          title: Text(
                            'parking',
                            style: TextStyle(fontSize: 13),
                          ),
                          value: widget.model.commodite?[0].parking == 1
                              ? true
                              : false,
                          onChanged: (value) {
                            setState(() {
                              // cuisineChecked = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hôte',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  // Ajout du SingleChildScrollView
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Entrez votre message',
                                                ),
                                                controller: _textController,
                                              ),
                                            ),
                                            SizedBox(width: 16.0),
                                            ElevatedButton(
                                              child: Text('Envoyer'),
                                              onPressed: () {
                                                context
                                                    .read<MessageReplyCubit>()
                                                    .getMessagePost(
                                                      _textController.text,
                                                      widget.model.idUser
                                                          .toString(),
                                                    );
                                                // Handle sending the message
                                                Navigator.of(context).pop();
                                                _textController.text = '';
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Discutez ',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Colors.blue),
                          ),
                        ),
                        title: Text(
                          widget.model.user?.name! ?? '',
                        ),
                      ),
                      BlocConsumer<MessageCubit, MessageState>(
                        builder: (context, state) {
                          return Container();
                        },
                        listener: (context, state) {
                          // return Container();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Text(
                        'Adresse',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.adresse!.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        child: GoogleMap(
                          // myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          // markers: _markers.values.toSet(),
                          // mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                newlatlang.latitude, newlatlang.longitude),
                            zoom: 7,
                          ),
                          onMapCreated: (controller) async {
                            String value = await DefaultAssetBundle.of(context)
                                .loadString('assets/map_style.json');
                            // controller.setMapStyle(value);
                            // setState(() {
                            //   mapController = controller;
                            //   log('message');
                            // });
                          },
                        ),
                      ),
                    ])),
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ReservationFormPage(
                          model: widget.model,
                        )),
              );
              // context.read<ReservationCubit>().getPostReservation( idHebergement:  widget.model.id.toString(), iduser:  widget.model.idUser.toString(), idpropio:  widget.model.user!.id!.toString(), dateDebut: dateDebut, montant: montant, dateFin: dateFin, reste: reste, avance: avance, nbrePerson: nbrePerson)
            },
            child: const Text(
              'Commandez ',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Poppins', color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
