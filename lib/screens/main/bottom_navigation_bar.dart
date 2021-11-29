import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ipark_sharing/api/lots.dart';
import 'package:ipark_sharing/models/lots.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/dimensions.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';

class BottomNavigationBar1 extends StatefulWidget {
  @override
  _BottomNavigationBar1State createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  int currentIndex;
  GoogleMapController _controller;
  bool isExpanded = false;
  LotsModel _lotsModel;
  List<Lots> items = [];
  List<Marker> allMarkers = [];
  int pressedLot = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    getSharingLots();
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

  void getSharingLots() async {
    try {
      final LotsModel lots = await iPark.ApiPanelGetLots();
      setState(() {
        _lotsModel = lots;
      });
      items.clear();
      for (int i = 0; i < _lotsModel.data.length; i++) {
        Lots obj = new Lots();
        obj.name = _lotsModel.data[i]["name"];
        obj.ID = _lotsModel.data[i]["ID"];
        obj.lat = _lotsModel.data[i]["lat"];
        obj.lon = _lotsModel.data[i]["lng"];
        print(_lotsModel.data[i]["name"]);
        items.add(obj);
      }
      items.forEach((element) async {
        final Uint8List markerIcon =
        await getBytesFromAsset("assets/images/atributes/location-pin.png", 120);
        setState(() {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon),
              markerId: MarkerId(element.name),
              draggable: false,
              onTap: () {
                pressedLot = items.indexOf(element);
                setState(() {
                  isExpanded = isExpanded == true ? false : true;
                });
              },
              position: LatLng(element.lat, element.lon)));
        });
      });
    } catch(e) {
      print(e);
    }
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: iParkColors.mainTextColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor: iParkColors.mainBackGroundcolor,
        color: iParkColors.mainBackGroundcolor,
        items: <Widget>[
          Icon(
            Icons.person_outline,
            size: 30,
            color: iParkColors.mainTextColor,
          ),
          Icon(
            Icons.map_outlined,
            size: 30,
            color: iParkColors.mainTextColor,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: iParkColors.mainTextColor,
          ),
        ],
        onTap: (int i) => changePage(i),
      ),
      body: (currentIndex == 0)
          ? Stack(
              children: [
                Positioned(
                  top: 40,
                  right: 40,
                  left: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: iParkColors.mainTextColor,
                        backgroundImage: NetworkImage(
                            "https://scontent.fksc2-1.fna.fbcdn.net/v/t39.30808-6/240474532_4702745656416132_895685324867087184_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=eE9FiMm-CSEAX_U0RFA&_nc_ht=scontent.fksc2-1.fna&oh=6c6e0fc24f1719e59e2d213c61771a7e&oe=61A841C5"),
                        maxRadius: size.width * 0.15,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          UserPreferences.getSaveUserFirstName() +
                              " " +
                              UserPreferences.getSaveUserSecondName(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          UserPreferences.getSaveUserEmail(),
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                NestedScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, isScolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        collapsedHeight: kToolbarHeight,
                        expandedHeight: size.height * 0.26,
                        actions: [
                          IconButton(
                            color: iParkColors.mainBackGroundcolor,
                            icon: const Icon(Icons.more_vert_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ];
                  },
                  body: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: iParkColors.mainBackGroundcolor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: iParkColors.mainTextColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: iParkColors.mainBackGroundcolor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pridať miesto na share',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.add_circle,
                                        size: 30,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: iParkColors.mainBackGroundcolor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Moje platby',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.money_rounded,
                                        size: 30,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: iParkColors.mainBackGroundcolor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Odhlásiť sa',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.logout_outlined,
                                        size: 30,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : (currentIndex == 1)
              ? Stack(children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      padding: EdgeInsets.only(
                          bottom: (!isExpanded) ? MediaQuery.of(context).size.height * 0.16 :  MediaQuery.of(context).size.height * 0.25,
                          left: 10),
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
                      onTap: (lat) {
                        setState(() {
                          isExpanded = false;
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
                      height: (!isExpanded)
                          ? MediaQuery.of(context).size.height * 0.16
                          : MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: iParkColors.mainTextColor,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (!isExpanded)
                                ? bodyWidget(context)
                                : lowWidget(context)
                          ]),
                    ),
                  ),
                ])
              : Center(
                  child: Text('BOH XD'),
                ),
    );
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if ((timeNow > 4) && (timeNow <= 8)) {
      return "Dobre ráno, ";
    } else if ((timeNow > 8) && (timeNow <= 18)) {
      return "Dobrý deň, ";
    } else if ((timeNow > 18) && (timeNow <= 22)) {
      return "Dobrý večer, ";
    } else {
      // 22 && 4
      return "Príjemnú dobrú noc, ";
    }
  }

  lowWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              greetingMessage() +
                  " " +
                  UserPreferences.getSaveUserFirstName() +
                  ".",
              style: iPark.subtitleTextStyle(iParkColors.mainBackGroundcolor),
              textAlign: TextAlign.left,
            ),
          ),
          height5Space,
          Container(
            alignment: Alignment.center,
            child: Text(
              items[pressedLot].name.toUpperCase(),
              maxLines: 1,
              style: iPark.headerInfoTextStyle(Theme
                  .of(context)
                  .secondaryHeaderColor),
            ),
          ),
          height20Space,
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
          child:
          Container(
            height: 50,
            color: Colors.transparent,
            child: iPark.iParkSignButton(
                context: context,
                text: "rezervovať".toUpperCase(),
                onClicked: () async {
                  iPark.iParkLoadingDialog(context);
                }),
          ),
          ),
        ],
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              greetingMessage() +
                  " " +
                  UserPreferences.getSaveUserFirstName() +
                  ".",
              style: iPark.subtitleTextStyle(iParkColors.mainBackGroundcolor),
              textAlign: TextAlign.left,
            ),
          ),
          height5Space,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CustomStyle.cornerPadding),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(CustomStyle.cornerPadding),
                  color: iParkColors.mainBackGroundcolor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {},
                    splashColor: Theme.of(context).secondaryHeaderColor,
                    borderRadius:
                        BorderRadius.circular(CustomStyle.cornerPadding),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            Img.get('atributes/parked-car.png'),
                            fit: BoxFit.cover,
                            color: iParkColors.mainBackGroundcolor,
                          ),
                        ),
                        backgroundColor: iParkColors.mainTextColor,
                      ),
                      title: Text(
                        "Nemáte voľné miesto?",
                        style:
                            iPark.subtitleTextStyle(iParkColors.mainTextColor),
                      ),
                    ),
                  ),
                ),
              ),
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
