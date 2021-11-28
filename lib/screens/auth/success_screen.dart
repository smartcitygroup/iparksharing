import 'package:flutter/material.dart';
import 'package:ipark_sharing/api/get_info.dart';
import 'package:ipark_sharing/screens/main/bottom_navigation_bar.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/dimensions.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../auth/login.dart';

//TODO: Dokončiť
class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  GetInfoModel _getInfo;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void dispose() {
    super.dispose();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    if (UserPreferences.getUserToken() != null) {
      final GetInfoModel info = await iPark.ApiGetInfo(
          UserPreferences.getUserToken(), UserPreferences.getSaveUserID());
      setState(() {
        _getInfo = info;
      });
      UserPreferences.saveUserFirstName(_getInfo.first_name);
      UserPreferences.saveUserSecondName(_getInfo.second_name);
      UserPreferences.saveUserPhone(_getInfo.phone);
      UserPreferences.saveUserEmail(_getInfo.email);
      if (_getInfo.wallet == null) {
        UserPreferences.saveUserWallet("0,00");
      } else {
        UserPreferences.saveUserWallet(_getInfo.wallet);
      }
      return new Timer(duration, AutoLoginPage);
    } else {
        return new Timer(duration, SignInPage);
    }
  }

  void SignInPage() {
    Navigator.pop(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
  }

  void AutoLoginPage() {
    Navigator.pop(context);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavigationBar1()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: iParkColors.mainBackGroundcolor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.topCenter,
                    child: Image.asset(Img.get('atributes/happy.png'),
                        fit: BoxFit.cover),
                  ),
                SizedBox(
                  height: Dimensions.heightSize * 3,
                ),
                Text(
                  "Hotovo!",
                  style: TextStyle(
                      color: iParkColors.mainTextColor,
                      fontSize: Dimensions.extraLargeTextSize * 2,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: Dimensions.heightSize),
                Text(
                  "Čoskoro ste prihlásený!",
                  style: TextStyle(
                    color: iParkColors.mainTextColor,
                      fontSize: Dimensions.largeTextSize,),
                ),
                  SizedBox(height: Dimensions.heightSize * 6),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
