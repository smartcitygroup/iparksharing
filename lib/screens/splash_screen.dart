import 'package:flutter/material.dart';
import 'package:ipark_sharing/api/get_info.dart';
import 'package:ipark_sharing/screens/auth/login.dart';
import 'package:ipark_sharing/screens/main/bottom_navigation_bar.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Dokončiť
class SplashScreen extends StatefulWidget {
  static const String routeName = 'splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetInfoModel _getInfo;

  startTime() async {
    var duration = new Duration(seconds: 2);
    if (UserPreferences.getUserToken() != null) {
      try {
        final GetInfoModel info = await iPark.ApiGetInfo(
          UserPreferences.getUserToken(),
          UserPreferences.getSaveUserID(),
        );
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
      } catch (e) {
        return new Timer(duration, NoInternet);
      }
      return new Timer(duration, AutoLoginPage);
    } else {
      return new Timer(duration, SignInPage);
    }
  }

  void NoInternet() {
    /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainHandler(statusHandler: 0)));*/
  }

  void SignInPage() {
   Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
  }

  void AutoLoginPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigationBar1()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: iParkColors.mainBackGroundcolor,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("iPark Sharing", textAlign: TextAlign.center, style: TextStyle(color: iParkColors.mainTextColor, fontWeight: FontWeight.w900, fontSize: 30),)
              ],
            ),
          ),
          Container(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(Img.get('scgp_logo_full_white.png'),
                      color: iParkColors.mainTextColor, fit: BoxFit.cover),
                ),
                Text(
                  "Version: 0.0.1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: iParkColors.mainTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 8),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
