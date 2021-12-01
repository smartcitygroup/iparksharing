import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipark_sharing/api/add_lots.dart';
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
  LotsAddModel _lotsAddModel;
  TextEditingController descriptionInfo = TextEditingController(text: "");
  String fromDate = Tools.getFormattedDateSimple(DateTime.now().millisecondsSinceEpoch)
      .toString();
  String toDate = Tools.getFormattedDateSimple(DateTime.now().millisecondsSinceEpoch)
      .toString();
  Future<DateTime> selectedDateFrom;
  Future<DateTime> selectedDateTo;


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
                    "Rezervovať miesto",
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
              text: "PRIDAŤ",
              onClicked: () async {

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
              height5Space,
              Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    showToDatePicker(context);
                  },
                  color: iParkColors.mainBackGroundcolor,
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
                        backgroundColor: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(toDate, style: TextStyle(
                          color: iParkColors.mainBackGroundcolor, fontSize: 14)),
                    ],
                  ),
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
      });
    }, onError: (error) {
      print(error);
    });
  }
}

class ExpansionItem {
  bool isExpanded;
  String header;
  String body;
  int num;

  ExpansionItem({this.isExpanded = false, this.header, this.body, this.num});
}
