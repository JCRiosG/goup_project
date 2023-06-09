import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_up/src/utils/snackbar.dart' as utils;

class DriverMapController{

  late BuildContext context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(22.460685,-97.9702712),
    zoom: 15.0
  );

  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  late Position _position;
  late StreamSubscription<Position> _positionStream;
  late BitmapDescriptor markerDriver;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    markerDriver = await createMarkerImageFromAsset('assets/images/bus_vistasuperior.png');
    checkGPS();
  }

  void onMapCreated(GoogleMapController controller){
    //controller.setMapStyle('[{"elementType": "geometry","stylers": [{"color": "#242f3e"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#746855"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#242f3e"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "road","elementType": "geometry","stylers": [{"color": "#38414e"}]},{"featureType": "road","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#746855"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"color": "#17263c"}]}]');
    _mapController.complete(controller);
  }

  void updateLocation () async{
    try{
      await _determinePosition();
      _position = (await Geolocator.getLastKnownPosition())!;
      centerPosition();
      addMarker('Conductor', _position.latitude, _position.longitude, 'Mi posicion', '', markerDriver);
      refresh();
      _positionStream = Geolocator.getPositionStream().listen((Position position) {
        _position = position;
        addMarker('Conductor', _position.latitude, _position.longitude, 'Mi posicion', '', markerDriver);
        animateCameraToPosition(_position.latitude, _position.longitude);
        refresh();
      });
    }catch(error){
      print('Error en la localizacion: $error');
    }
  }

  void centerPosition(){
    if(_position != null){
      animateCameraToPosition(_position.latitude,_position.longitude);
    }else{
      utils.Snackbar.showSnackbar(context, key, 'Activa el GPS para obtener la posicion actual');
    }
  }

  void checkGPS() async{
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(isLocationEnabled){
      print('GPS Activado');
      updateLocation();
    }else{
      print('GPS Desactivado');
      bool locationGPS = await location.Location().requestService();
      if(locationGPS){
        updateLocation();
        print('Activo el GPS');
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future animateCameraToPosition(latitude, longitud) async{
    GoogleMapController controller = await _mapController.future;
    if(controller != null){
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing:0,
            target: LatLng(latitude,longitud),
            zoom: 17
          ),
        )
      );
    }
  }

  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async{
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(String markerId, double lat, double lng, String title, String content, BitmapDescriptor iconMarker){
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(title: title, snippet: content),
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5,0.5),
      rotation: _position.heading
    );

    markers[id] = marker;
  }

}