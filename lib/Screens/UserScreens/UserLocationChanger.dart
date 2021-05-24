import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:swap/Screens/UserScreens/EditProfile.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
class LocationChanger extends StatefulWidget {
  @override
  final LocationData location;
  LocationChanger({this.location});
  _LocationChangerState createState() => _LocationChangerState();
}

Size size;
double zoomValue = 15;


class _LocationChangerState extends State<LocationChanger> {
  String dropdownValue;
  List<String> cityList = [
    'Ajman',
    'Al Ain',
    'Dubai',
    'Fujairah',
    'Ras Al Khaimah',
    'Sharjah',
    'Umm Al Quwain'
  ];
  int _value = 6;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  static Location _location = Location();
  LocationData _locationData;
  List<Marker> _markers = <Marker>[];
  static double  currentLocationLatitude, currentLocationLongitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_locationData = location.get
    //maptype = MapType.satellite;
  }

  // final coordinates = new Coordinates(1.10, 45.50);
  // addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates).toString();
  // first = addresses.first;
  // print("${first.featureName} : ${first.addressLine}");
  
  getUserLocation() async {//call this async method from whereever you need
    
      LocationData myLocation;
      String error;
      Location location = new Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      //currentLocation = myLocation;
      final coordinates = new Coordinates(
          myLocation.latitude, myLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      return first;
    }
    MapType _currentMapType = MapType.normal;  
  
    // Map<MarkerId, Marker> markers = <MarkerId, Marker>{MarkerId('marker_id_1'):Marker(
    // markerId: MarkerId('marker_id_1'),
    // position: LatLng(currentLocationLatitude, currentLocationLongitude),
    // infoWindow: InfoWindow(title: 'marker_id_1', snippet: '*'),
    // onTap: () async{
    //   _location.onLocationChanged.listen((l){
    //     currentLocationLatitude = l.latitude;
    //     currentLocationLongitude = l.longitude;
    //   });
    //   setState(() {
        
    //   });
    //   //_onMarkerTapped(markerId);
    //   print('Marker Tapped');
    // },
    // onDragEnd: (LatLng position) {
    //   print('Drag Ended');
    // },  )};
  void _onMapTypeButtonPressed() {  
    setState(() {  
      //String name = _location.
      _currentMapType = _currentMapType == MapType.normal  
          ? MapType.satellite  
          : MapType.normal;  
    });  
  }  
  
  void _handleTap(LatLng tappedPosition){
    setState(() {
      _markers =[];
    _markers.add(
      Marker(
        markerId: MarkerId(tappedPosition.toString()),
        position: tappedPosition
      )
    );
    });
  }
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      print(l.toString());
        _markers =[];
        _markers.add(
          Marker(
            markerId: MarkerId(l.toString()),
            position:LatLng(l.latitude, l.longitude), 
          ));
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude, l.longitude), 
              zoom: zoomValue
            ),
        ),
      );
      getUserLocation();
      CupertinoAlertDialog(
        title: new Text("Dialog Title"),
        content: new Text("This is my content"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Yes"),
          ),
          CupertinoDialogAction(
            child: Text("No"),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Change Location"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              height: size.height * 0.6,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition),
                  mapType: _currentMapType ,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: false,
                  markers: Set.from(_markers),
                  //polylines: Set<Polyline>.of(_mapPolylines.values),
                ),
                Padding(  
                  padding: const EdgeInsets.all(14.0),  
                  child: Align(  
                    alignment: Alignment.topRight,  
                    child: FloatingActionButton(  
                      onPressed: _onMapTypeButtonPressed,  
                      materialTapTargetSize: MaterialTapTargetSize.padded,  
                      backgroundColor: Colors.green,  
                      child: const Icon(Icons.map, size: 30.0),  
                    ),  
                  ),  
                ),  
                ]
              ),
            ),
            //SizedBox(height: size.height*0.1,),
            Expanded(
                child: Slider(
                    value: _value.toDouble(),
                    min: 1.0,
                    max: 30.0,
                    divisions: 10,
                    activeColor: Colors.purple,
                    inactiveColor: Colors.blue,
                    label: '$zoomValue',
                    onChanged: (double newValue) {
                      setState(() {
                        _value = newValue.round();
                        zoomValue = _value.toDouble();
                      });
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} dollars';
                    })),
            //SizedBox(height: size.height*0.1,),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.1, 0, size.width * 0.1, size.height * 0.1),
              child: ButtonTheme(
                minWidth: 00.0,
                height: size.height * 0.07,
                child: RaisedButton(
                    elevation: 5,
                    color: Colors.purple[400],
                    onPressed: () {
                      //debugPrint("SnackBar called");
                      return Fluttertoast.showToast(
                          msg: "Location Updated",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.purple[300].withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: <Widget>[
                        Text("Set my current location",
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(
            //       size.width * 0.1, 0, size.width * 0.1, size.height * 0.05),
            //   child: DecoratedBox(
            //     decoration: ShapeDecoration(
            //       color: Colors.cyan,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             width: 1.0, style: BorderStyle.solid, color: Colors.cyan),
            //         borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //       ),
            //     ),
            //     child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
            //       child: DropdownButton<String>(
            //         value: dropdownValue,
            //         icon: Icon(null),
            //         elevation: 16,
            //         onChanged: (String newValue) {
            //           setState(() {
            //             dropdownValue = newValue;
            //           });
            //         },
            //         underline: SizedBox(),
            //         items: <String>['City', 'Country', 'State']
            //             .map<DropdownMenuItem<String>>((String value) {
            //           return DropdownMenuItem<String>(
            //             value: value,
            //             child: Text(value),
            //           );
            //         }).toList(),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
// Completer<GoogleMapController> _controller = Completer();
// Set<Marker> _markers = Set<Marker>();
// CameraPosition cameraPosition = CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude));
// MapType _currentmapType = MapType.normal;
// Marker marker;

//   Map<PolylineId, Polyline> _mapPolylines = {};
// int _polylineIdCounter = 1;

// List<LatLng> _createPoints() {
//   final List<LatLng> points = <LatLng>[];
//   points.add(LatLng(1.875249, 0.845140));
//   points.add(LatLng(4.851221, 1.715736));
//   points.add(LatLng(8.196142, 2.094979));
//   points.add(LatLng(12.196142, 3.094979));
//   points.add(LatLng(16.196142, 4.094979));
//   points.add(LatLng(20.196142, 5.094979));
//   return points;
// }
// void _add() {
//   final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
//   _polylineIdCounter++;
//   final PolylineId polylineId = PolylineId(polylineIdVal);

//   final Polyline polyline = Polyline(
//     polylineId: polylineId,
//     consumeTapEvents: true,
//     color: Colors.red,
//     width: 5,
//     points: _createPoints(),
//   );

//   setState(() {
//     _mapPolylines[polylineId] = polyline;
//   });
// }
