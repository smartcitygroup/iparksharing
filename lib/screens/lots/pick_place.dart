import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ipark_sharing/screens/lots/add_sharing_lot.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/dimensions.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';

class PickPlace extends StatefulWidget {
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

class _PickPlaceState extends State<PickPlace> {
  GoogleMapController _controller;
  List<Marker> allMarkers = [];

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      changeMapMode();
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  changeMapMode() {
    getJsonFile("map/apptheme_map.json").then(setMapStyle);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: iParkColors.mainTextColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppBar(
              backgroundColor: iParkColors.mainTextColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0.0,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Kde sa nachádza vaše miesto?",
                    style: iPark.appBarTextStyle(Colors.white),
                  ),
                ],
              ),
              leading: IconButton(
                icon: iPark.iParkArrowBackButton(Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              fixPadding, fixPadding, fixPadding, fixPadding * 2),
          color: iParkColors.mainBackGroundcolor,
          height: 80.0,
          width: 70.0,
          child: iPark.iParkCustomButton(
              context: context,
              color: iParkColors.mainTextColor,
              text: "ĎALEJ",
              onClicked: () async {
                if(allMarkers.isEmpty) {
                  iPark.iParkSnackBar(context, "Prosím, kliknite na mape kde sa nachádza vaše miesto!", iParkColors.materialRedA400);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSharingLot(lat: allMarkers.single.position.latitude, lon: allMarkers.single.position.longitude),
                    ),
                  );
                }
              }),
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.18, left: 10),
            initialCameraPosition: CameraPosition(
                target: LatLng(49.05722903231597, 20.303223278767245),
                zoom: 14.0),
            markers: Set.of(allMarkers),
            onMapCreated: mapCreated,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            onTap: (lat) async {
              allMarkers.clear();
              final Uint8List markerIcon = await getBytesFromAsset(
                  "assets/images/atributes/location-pin.png", 120);
              setState(() {
                allMarkers.add(Marker(
                    icon: BitmapDescriptor.fromBytes(markerIcon),
                    markerId: MarkerId("1"),
                    draggable: false,
                    onTap: () {},
                    position: LatLng(lat.latitude, lat.longitude)));
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
            padding: MediaQuery.of(context).viewInsets,
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
              color: iParkColors.mainBackGroundcolor,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  bodyWidget(context)
                ]),
          ),
        ),
      ]),
    );
  }

  bodyWidget(BuildContext context) {
    String lati = (allMarkers.isEmpty) ? "KLIKNITE NA MAPU" : allMarkers.single.position.latitude.toString();
    String long = (allMarkers.isEmpty) ? "KLIKNITE NA MAPU" : allMarkers.single.position.longitude.toString();
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "GPS Poloha",
              maxLines: 1,
              style: iPark.headerInfoTextStyle(Theme
                  .of(context)
                  .secondaryHeaderColor),
            ),
          ),
          height20Space,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Latitude: " + lati,
              style: iPark.subtitleTextStyle(Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          height5Space,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Longitude: " + long,
              style: iPark.subtitleTextStyle(Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Container(height: 10),
          SizedBox(
            height: Dimensions.heightSize,
          ),
        ],
      ),
    );
  }
}
