import 'dart:developer';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunrise_hosting/data/model/google_place_model.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
// import 'package:sunrise_hosting/data/model/reservation_list_model.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/cubit/hebergement_cubit.dart';
import 'package:sunrise_hosting/features/house_place/logic/google_map_place_cubit.dart';
import 'package:sunrise_hosting/gen/colors.gen.dart';

class HousePlcaePage extends StatefulWidget {
  const HousePlcaePage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;
  @override
  State<HousePlcaePage> createState() => _HousePlcaePageState();
}

class _HousePlcaePageState extends State<HousePlcaePage> {
  Position? _position;
  GoogleMapController? mapController;
  final Map<String, Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  List<GooglePrediction> places = [];
  List<Data> modelProperty = [];
  double lat = 5.316667;
  double lng = -4.033333;
  @override
  void initState() {
    lat = 5.316667;
    lng = -4.033333;
    // _getCurrentLocation();
    print('object');
    // /annonces/search-by-coordinate?latitude= 0.33983929&longitude=1.39939944&distance=20
    context.read<HebergementCubit>().getHebergementList();
    super.initState();
  }

  // void _getCurrentLocation() async {
  //   final position = await _determinePosition();
  //   setState(() {
  //     // _position = position;
  //     // print('dddddddddddddddddddddddd' + _position.toString());
  //     lat = 5.316667;
  //     lng = -4.033333;
  //   });
  // }

  // Future<Position> _determinePosition() async {
  //   LocationPermission permission;

  //   permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location Permissions are denied');
  //     }
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

  // TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(5.316667, -4.033333),
    zoom: 12,
  );

  List<GooglePrediction> _searchResults = [];

  bool _isResultsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocConsumer<HebergementCubit, HebergementState>(
          listener: (context, state) {
            if (state is HebergementStateLoaded) {
              modelProperty = state.response.data ?? [];
              print(modelProperty);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is HebergementStateLoading) {
              return const Center(
                child: SpinKitDoubleBounce(
                  color: ColorName.btnGray,
                  size: 50.0,
                ),
              );
            }
            if (state is HebergementStateError) {
              return GoogleMap(
                // myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                markers: _markers.values.toSet(),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 15,
                ),
                onMapCreated: (controller) async {
                  // String value = await DefaultAssetBundle.of(context)
                  //     .loadString('assets/map_style.json');
                  // controller.setMapStyle(value);
                  setState(() {
                    mapController = controller;
                    log('message');
                  });
                },
              );
            }
            if (state is HebergementStateLoaded) {
              Set<Marker> markers = {};
              for (final element in state.response.data!) {
                inspect(
                    ' ${element.titre} long : ${element.lat.toString()} lat: ${element.long.toString()} image: ${element.images.toString()}lat: ${element.prix.toString()}');
                final marker = Marker(
                    markerId: MarkerId(element.id.toString()),
                    position: LatLng(
                      double.parse(element.lat.toString()),
                      double.parse(element.long.toString()),
                    ),
                    infoWindow: InfoWindow(
                      title: element.titre,
                      snippet: '',
                    ),
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Detail',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              element.images?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.transparent,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.43,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: element
                                                        .images![index]
                                                        .toString(),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: const Text('',
                                          // element.typeDeBien!.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          )),
                                      trailing: Text(element.typeLogement!),
                                      subtitle: Text(
                                          element.prix.toString() + ' FCFA'),
                                    ),
                                    const Text('Description',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        )),
                                    // Text(
                                    //     element.description.toString()),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     (context),
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           PropertyDetailPage(
                                          //               id: element.id
                                          //                   .toString(),
                                          //               type: ' ',
                                          //               isexpireToken: widget
                                          //                   .isexpireToken,
                                          //               ismapPageBack:
                                          //                   true),
                                          //     ));
                                          // (route) => false);
                                        },
                                        child: const Text(
                                          'Voir plus',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    });

                _markers[element.id.toString()] = marker;
              }
              return GoogleMap(
                // myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                markers: _markers.values.toSet(),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 15,
                ),
                onMapCreated: (controller) async {
                  // String value = await DefaultAssetBundle.of(context)
                  //     .loadString('assets/map_style.json');
                  // controller.setMapStyle(value);
                  setState(() {
                    mapController = controller;
                    log('updating markerr..................');
                  });
                },
              );
            }
            return Container();
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 60,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              color: Colors.transparent,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  hintText: 'Recherche...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (query) {
                  // Ajouter votre logique de recherche ici
                  setState(() {
                    setState(() {
                      context.read<GoogleMapPlaceCubit>().searchPlaces(query);
                    });
                    // _searchResults = [
                    //   'Résultat 1',
                    //   'Résultat 2',
                    //   'Résultat 3'
                    // ];
                    _isResultsVisible = true;
                  });
                },
              ),
            ),
          ),
        ),
        BlocBuilder<GoogleMapPlaceCubit, GoogleMapPlaceState>(
            builder: (context, state) {
          log(state.toString());
          if (state is GoogleMapPlaceInitial) {}
          if (state is GoogleMapPlaceStateLoaded) {
            // log(state.places.toString());
            // inspect(state.places);
            places = state.places;
            _searchResults = state.places;
          }

          if (state is GoogleMapPlaceDetailStateLoaded) {
            // log(state.geo!.geometry.location.lat);

            lat = state.geo!.geometry.location.lat;
            lng = state.geo!.geometry.location.lng;

            final newlatlang = LatLng(lat, lng);
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: newlatlang, zoom: 14),
                //17 is new zoom level
              ),
            );
          }

          // places.map((key, value) => Container()).toList();
          return Visibility(
              visible: _isResultsVisible && _searchResults.isNotEmpty,
              child: Positioned(
                  top: 90.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 150.0,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () {
                              _isResultsVisible = false;
                              context
                                  .read<GoogleMapPlaceCubit>()
                                  .getPlaceDetailsFromId(places[index].placeId);
                              // context
                              //     .read<PropertyListCubit>()
                              //     .getbyCordinate(lat, lng, 10000);
                            },
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                places[index].description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                        // separatorBuilder: (context, index) => const Divider(),
                      ))));
        }),
      ],
    )

        // separatorBuilder: (context, index) => const Divider(),

        );
  }
}
