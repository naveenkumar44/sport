// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class CurrentLocation extends StatefulWidget {
//   const CurrentLocation({Key? key}) : super(key: key);
//
//   @override
//   State<CurrentLocation> createState() => _CurrentLocationState();
// }
//
// class _CurrentLocationState extends State<CurrentLocation> {
//   Completer<GoogleMapController> _controller = Completer();
//   static LatLng _center = LatLng(45.521563, -122.677433);
//   final Set<Marker> _marker = {};
//   LatLng _lastMapPstition = _center;
//   MapType _currentMapType = MapType.normal;
//   static final CameraPosition _position = CameraPosition(
//       bearing: 192.833,
//       target: LatLng(45.521563, -122.677433),
//       tilt: 59.440,
//       zoom: 11);
//   Future<void> _goToPosition1() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_position));
//   }
//
//   _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }
//
//   _onCameraMove(CameraPosition position) {
//     _lastMapPstition = position.target;
//   }
//
//   _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }
//
//   _onAddMarKerButtonPressed() {
//     setState(() {
//       _marker.add(Marker(
//         markerId: MarkerId(_lastMapPstition.toString()),
//         position: _lastMapPstition,
//         infoWindow: InfoWindow(title: "this is a Title", snippet: "This"),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//   }
//
//   Widget button(Function function, IconData icon) {
//     return FloatingActionButton(
//       onPressed: function(),
//       materialTapTargetSize: MaterialTapTargetSize.padded,
//       backgroundColor: Colors.blue,
//       child: Icon(
//         icon,
//         size: 36.0,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
//             mapType: _currentMapType,
//             markers: _marker,
//             onCameraMove: _onCameraMove,
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Column(
//                 children: [
//                   button(_onMapTypeButtonPressed, Icons.map),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   button(_onAddMarKerButtonPressed, Icons.add_location),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   button(_goToPosition1, Icons.location_searching),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
