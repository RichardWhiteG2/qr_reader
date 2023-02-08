
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/db_provider.dart';


class MapaPage extends StatefulWidget {
   
  
  
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType mapType =MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntoInicial = CameraPosition(
    target: scan.getLatLng(),//LatLng(19.3592782, -99.2791445),
    zoom: 17,
    tilt: 50,
    );
    //Marcadores:
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: scan.getLatLng(),
      )
    );

    return  Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching_outlined),
            onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50,
                  )
                )
              );
            },
          )
        ],
      ),
      body:GoogleMap(
        zoomControlsEnabled: false,
        markers: markers,
        myLocationButtonEnabled: true,
        mapType: mapType, //Cambia el tipo de mapa
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed:(() {
          
            if(mapType == MapType.normal){
              mapType= MapType.satellite;
            }else{
              mapType= MapType.normal;
            }
            //Redibujar el estado cambiando
            setState(() { });
          } 
        ),
      )
    );
  }
}