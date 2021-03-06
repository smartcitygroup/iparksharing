import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipark_sharing/api/add_lots.dart';
import 'package:ipark_sharing/api/add_reservation.dart';
import 'package:ipark_sharing/screens/main/bottom_navigation_bar.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/tools.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:ipark_sharing/widgets/textfield_widget.dart';
import 'package:ipark_sharing/widgets/textfield_widget_support.dart';
import 'package:provider/provider.dart';

class ReserveSharingLot extends StatefulWidget {
  final int ID;

  const ReserveSharingLot({Key key, @required this.ID,}) : super(key: key);

  @override
  _ReserveSharingLotState createState() => _ReserveSharingLotState();
}

class _ReserveSharingLotState extends State<ReserveSharingLot> {
  ReservationModel _reservationModel;
  TextEditingController descriptionInfo = TextEditingController(text: "");
  String fromDate = Tools.getFormattedDateSimple(DateTime.now().millisecondsSinceEpoch)
      .toString();
  String toDate = Tools.getFormattedDateSimple(DateTime.now().millisecondsSinceEpoch)
      .toString();
  Future<DateTime> selectedDateFrom;
  Future<DateTime> selectedDateTo;

  TimeOfDay selectedEntranceTime = TimeOfDay.now();
  String entranceTime = '00:00';

  TimeOfDay selectedExitTime = TimeOfDay.now();
  String exitTime = '01:00';

  String ecvController = "";
  double toDateNum;
  double fromDateNum;

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
                    "Rezervova?? miesto",
                    style: iPark.appBarTextStyle(
                        Colors.white),
                  ),
                ],
              ),
              leading: IconButton(
                icon: iPark.iParkArrowBackButton(
                    Colors.white),
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
              text: "PRIDA??",
              onClicked: () async {
                  iPark.iParkLoadingDialog(context);
                  try {
                    final ReservationModel response =
                    await iPark.ApiAddReservation(widget.ID, UserPreferences.getSaveUserID(), UserPreferences.getUserToken(),
                      toDateNum, fromDateNum, ecvController,);
                    setState(() {
                      _reservationModel = response;
                    });
                    if(_reservationModel.error_message != null) {
                      switch(_reservationModel.error_message) {
                        case "selected_time_is_not_available": {
                          iPark.iParkSnackBar(context, "Zadan?? d??tum nie je dostupn??!", iParkColors.materialRedA400);
                          break;
                        }
                        case "slot_was_not_found": {
                          iPark.iParkSnackBar(context, "Zadane miesto uz pravdepodobne neexistuje", iParkColors.materialRedA400);
                          break;
                        }
                        case "selected_time_is_reserved": {
                          iPark.iParkSnackBar(context, "Zadan?? ??as u?? je rezervovan??!", iParkColors.materialRedA400);
                          break;
                        }
                        case "reservation_was_not_found": {
                          iPark.iParkSnackBar(context, "Rezerv??cia sa nena??la", iParkColors.materialRedA400);
                          break;
                        }
                        case "cant_create_reservation": {
                          iPark.iParkSnackBar(context, "Nepodarilo sa vytvori?? rezerv??ciu", iParkColors.materialRedA400);
                          break;
                        }
                      }
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      iPark.iParkSnackBar(context, "Rezerv??cia bola ??spe??n??!", iParkColors.materialGreenA400);
                    }
                    Navigator.pop(context);
                  } catch(e) {
                    Navigator.pop(context);
                    iPark.iParkSnackBar(context, "Zl?? internetov?? pripojenie!", iParkColors.materialRedA400);
                    print(e);
                  }
              }),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: iParkColors.mainTextColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(CustomStyle.cornerPadding),
              topLeft: Radius.circular(CustomStyle.cornerPadding),
            ),
            color: iParkColors.mainBackGroundcolor,
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(height: 20),
              Container(
                padding: EdgeInsets.only(left: 13),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Platnos?? rezerv??cie od:",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              heightSpace,
              Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    showToDatePicker(context);
                  },
                  color: iParkColors.mainTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                              Img.get('atributes/calendar.png'),
                              fit: BoxFit.cover),
                        ),
                        backgroundColor: iParkColors.mainBackGroundcolor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(toDate, style: TextStyle(
                          color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              heightSpace,
              Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    _selectEntranceTime(context);
                  },
                  color: iParkColors.mainTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                              Img.get(
                                  'atributes/wall-clock.png'),
                              fit: BoxFit.cover),
                        ),
                        backgroundColor: iParkColors.mainBackGroundcolor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(entranceTime,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              height20Space,
              Container(
                padding: EdgeInsets.only(left: 13),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Platnos?? rezerv??cie do:",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              heightSpace,
              Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    showFromDatePicker(context,);
                  },
                  color: iParkColors.mainTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                              Img.get('atributes/calendar.png'),
                              fit: BoxFit.cover),
                        ),
                        backgroundColor: iParkColors.mainBackGroundcolor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(fromDate, style: TextStyle(
                          color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              heightSpace,
              Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    _selectExitTime(context);
                  },
                  color: iParkColors.mainTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                              Img.get(
                                  'atributes/wall-clock.png'),
                              fit: BoxFit.cover),
                        ),
                        backgroundColor: iParkColors.mainBackGroundcolor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(exitTime,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              height20Space,
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'E??V vozidla',
                      obscureText: false,
                      color: iParkColors.mainTextColor,
                      enabled: true,
                      imgAtributes: "atributes/sports-car.png",
                      imgSuffix: null,
                      onChanged: (value) {
                        ecvController = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              height5Space,
            ]),
          ),
        ),
      ),
    );
  }

  void showToDatePicker(BuildContext context,) {
    selectedDateTo = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    selectedDateTo.then((value) {
      setState(() {
        if (value == null) return;
        toDate = Tools.getFormattedDateSimple(value.millisecondsSinceEpoch);
        toDateNum = (value.millisecondsSinceEpoch / 1000);
      });
    }, onError: (error) {
      print(error);
    });
  }

  void showFromDatePicker(BuildContext context) {
    selectedDateFrom = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    selectedDateFrom.then((value) {
      setState(() {
        if (value == null) return;
        fromDate = Tools.getFormattedDateSimple(value.millisecondsSinceEpoch);
        fromDateNum = (value.millisecondsSinceEpoch / 1000);
      });
    }, onError: (error) {
      print(error);
    });
  }

  Future<void> _selectEntranceTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedEntranceTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedEntranceTime) {
      setState(() {
        selectedEntranceTime = pickedTime;
        entranceTime = selectedEntranceTime
            .toString()
            .split('TimeOfDay(')[1]
            .split(')')[0];
        print('2 : ' + entranceTime);
      });
      print(selectedEntranceTime.periodOffset);
      var finalTime = selectedEntranceTime.hour * 3600 + selectedEntranceTime.minute * 60;
      //saveMainPriceList("&open_from=" + finalTime.toString());
    }
  }

  Future<void> _selectExitTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedExitTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedExitTime) {
      setState(() {
        selectedExitTime = pickedTime;

        exitTime =
        selectedExitTime.toString().split('TimeOfDay(')[1].split(')')[0];
        print('2 : ' + exitTime);
      });
      var finalTime = selectedExitTime.hour * 3600 + selectedExitTime.minute * 60;
      //saveMainPriceList("&open_to=" + finalTime.toString());
    }
  }
}

class ExpansionItem {
  bool isExpanded;
  String header;
  String body;
  int num;

  ExpansionItem({this.isExpanded = false, this.header, this.body, this.num});
}
