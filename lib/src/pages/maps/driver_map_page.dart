import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_up/src/widgets/button_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_up/src/utils/colors.dart' as UtilsColors;
import 'package:go_up/src/pages/maps/driver_map_controller.dart';

class DriverMapPage extends StatefulWidget{
  @override
  _DriverMapPageState createState() => _DriverMapPageState();

}

class _DriverMapPageState extends State<DriverMapPage>{

  DriverMapController _con = new DriverMapController();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
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
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
    );
  }
  void refresh(){
    setState(() {

    });
  }

  Widget _btnCenterPosition(){
    return Container(
      alignment: Alignment.centerRight,
      margin:EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: CircleBorder(),
        color: Colors.white,
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