import 'package:flutter/material.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/widgets/textfield_widget.dart';
import 'package:ipark_sharing/widgets/textfield_widget_support.dart';
import 'package:provider/provider.dart';

class AddSharingLot extends StatefulWidget {

  final double lat;
  final double lon;

  const AddSharingLot({Key key,
    @required this.lat,
    @required this.lon,
  }) : super(key: key);

  @override
  _AddSharingLotState createState() => _AddSharingLotState();
}

class _AddSharingLotState extends State<AddSharingLot> {
  TextEditingController descriptionInfo = TextEditingController(text: "");

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
                    "Pridať miesto na share",
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
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFieldWidget(
                    hintText: 'Vlastný názov',
                    obscureText: false,
                    color: iParkColors.mainTextColor,
                    enabled: true,
                    imgAtributes: "atributes/parking.png",
                    imgSuffix: null,
                    onChanged: (value) {
                      //emailController = value;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              ),
              height5Space,
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Tel. číslo na vás',
                      obscureText: false,
                      color: iParkColors.mainTextColor,
                      enabled: true,
                      imgAtributes: "atributes/call.png",
                      imgSuffix: null,
                      onChanged: (value) {
                        //emailController = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              height5Space,
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'E-mail na vás',
                      obscureText: false,
                      color: iParkColors.mainTextColor,
                      enabled: true,
                      imgAtributes: "atributes/open-email.png",
                      imgSuffix: null,
                      onChanged: (value) {
                        //emailController = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              height5Space,
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidgetSupport(
                      hintText: "Info",
                      obscureText: false,
                      enabled: true,
                      color: iParkColors.mainTextColor,
                      imgAtributes: "atributes/info_new.png",
                      imgSuffix: null,
                      onChanged: (value) {

                      },
                      controller: descriptionInfo,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kontaktné údaje",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    heightSpace,
                    Text(
                      "BLABLABlABLA",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Theme
                            .of(context)
                            .secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kontaktné údaje",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    heightSpace,
                    Text(
                      "BLABLABlABLA",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Theme
                            .of(context)
                            .secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class ExpansionItem {
  bool isExpanded;
  String header;
  String body;
  int num;

  ExpansionItem({this.isExpanded = false, this.header, this.body, this.num});
}
