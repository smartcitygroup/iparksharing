import 'package:flutter/material.dart';
import 'package:ipark_sharing/api/add_lots.dart';
import 'package:ipark_sharing/screens/main/bottom_navigation_bar.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
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
  LotsAddModel _lotsAddModel;
  TextEditingController descriptionInfo = TextEditingController(text: "");
  String nameController = "";
  String phoneController = "";
  String emailController = "";
  String loreController = "";

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
                    "Prida?? miesto na share",
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
                if(nameController.toString().isNotEmpty && emailController.toString().isNotEmpty &&
                phoneController.toString().isNotEmpty && loreController.toString().isNotEmpty) {
                  iPark.iParkLoadingDialog(context);
                  try {
                    // TODO: Je parkovisko vo??ne otvoren??? is_open....
                    final LotsAddModel response =
                    await iPark.ApiAddLots(nameController, widget.lat, widget.lon, UserPreferences.getSaveUserID(), UserPreferences.getUserToken(),
                    " ", 1, phoneController, loreController, emailController);
                    setState(() {
                      _lotsAddModel = response;
                    });
                    if(_lotsAddModel.code == 200) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      iPark.iParkSnackBar(context, "??spe??ne pridan??!", iParkColors.materialGreenA400);
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigationBar1()));
                    } else {
                      iPark.iParkSnackBar(context, "Zl?? internetov?? pripojenie!", iParkColors.materialRedA400);
                    }
                    Navigator.pop(context);
                  } catch(e) {
                    Navigator.pop(context);
                    iPark.iParkSnackBar(context, "Zl?? internetov?? pripojenie!", iParkColors.materialRedA400);
                    print(e);
                  }
                } else {
                  iPark.iParkSnackBar(context, "Pros??m vyplnte v??etky polia!", iParkColors.materialRedA400);
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
              height5Space,
              Padding(padding: EdgeInsets.only(right: 13, left: 16),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFieldWidget(
                    hintText: 'Vlastn?? n??zov',
                    obscureText: false,
                    color: iParkColors.mainTextColor,
                    enabled: true,
                    imgAtributes: "atributes/parking.png",
                    imgSuffix: null,
                    onChanged: (value) {
                      nameController = value;
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
                      hintText: 'Tel. ????slo na v??s',
                      obscureText: false,
                      color: iParkColors.mainTextColor,
                      enabled: true,
                      imgAtributes: "atributes/call.png",
                      imgSuffix: null,
                      onChanged: (value) {
                        phoneController = value;
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
                      hintText: 'E-mail na v??s',
                      obscureText: false,
                      color: iParkColors.mainTextColor,
                      enabled: true,
                      imgAtributes: "atributes/open-email.png",
                      imgSuffix: null,
                      onChanged: (value) {
                        emailController = value;
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
                          loreController = value;
                      },
                      controller: descriptionInfo,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text(
                        "Parkovisko vo??ne otvoren??",
                        style: CustomStyle.listStyle,
                      ),
                      leading: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.topCenter,
                        child: Image.asset(Img.get('atributes/parking.png'),
                            fit: BoxFit.cover),
                      ),
                      trailing: Switch.adaptive(
                          value: true,
                          onChanged: (value) async {
                            iPark.iParkSnackBar(context, "Aktu??lne sa daj?? iba vo??ne otvoren?? parkoviska prida??!", iParkColors.materialYellowA400);
                          }),
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
