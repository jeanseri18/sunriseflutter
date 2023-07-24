import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HousePlcaePage extends StatefulWidget {
  const HousePlcaePage(
      {super.key, required this.isexpireToken, required this.index});
  final int index;
  final bool isexpireToken;
  @override
  State<HousePlcaePage> createState() => _HousePlcaePageState();
}

class _HousePlcaePageState extends State<HousePlcaePage> {
  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
