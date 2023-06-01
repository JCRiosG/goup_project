import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_up/src/widgets/button_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_up/src/utils/colors.dart' as UtilsColors;


import 'client_map_controller.dart';

class ClientMapPage extends StatefulWidget{
  @override
  _ClientMapPageState createState() => _ClientMapPageState();

}

class _ClientMapPageState extends State<ClientMapPage>{

  ClientMapController _con = new ClientMapController();
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _btnMenu(),
                    _btnCenterPosition()
                  ],
                ),
                Expanded(child: Container()),
                _btnConect(),
              ],
            ),
          )
        ],
      )
    );
  }
  //@22.460685,-97.9702712,15z
  Widget _googleMapsWidget(){
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: true,
    );
  }
  Widget _btnCenterPosition(){
    return Container(
      alignment: Alignment.centerRight,
      margin:EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: CircleBorder(),
        color: UtilsColors.Colors.appColorNaranja,
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.location_searching,
            color: Colors.grey,
            size:20,
          ),
        ),
      ),
    );
  }
  Widget _btnMenu(){
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: (){},
        icon: Icon(Icons.menu, color: Colors.black,),
      ),
    );
  }
  Widget _btnConect(){
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: ButtonApp(
        text: 'Conectarse',
        color: Colors.amber,
        textColor:Colors.black,
      ),
    );
  }
}