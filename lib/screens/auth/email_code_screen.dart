import 'package:flutter/material.dart';
import 'package:ipark_sharing/api/code_check_model.dart';
import 'package:ipark_sharing/screens/auth/email_code_confirmation.dart';
import 'package:ipark_sharing/screens/auth/success_screen.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = 'emailVerificationScreen';

  final String emailAddress;

  const EmailVerificationScreen({Key key, this.emailAddress}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController mobileController = TextEditingController();
  String _emailAddress;
  CodeCheckModel _checkModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAddress = widget.emailAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iParkColors.mainTextColor,
      body: Stack(
        children: [verificationWidget(context)],
      ),
    );
  }

  Widget verificationWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: EmailConfirmation(
              title: "",
              image: 'assets/tik.png',
              subTitle: "Odoslali sme vám kód na váš e-mail.",
              phoneNumber: _emailAddress,
              otpLength: 6,
              validateOtp: validateOtp,
              routeCallback: moveToNextScreen,
              titleColor: iParkColors.mainTextColor,
              themeColor: iParkColors.mainTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> validateOtp(String otp) async {
    iPark.iParkLoadingDialog(context);
    try {
      final CodeCheckModel check = await iPark.ApiCheckEmailCode(
          UserPreferences.getSaveUserEmail(), otp);
      setState(() {
        _checkModel = check;
        Navigator.pop(context);
      });
      if (_checkModel.code == 200) {
        UserPreferences.setUserToken(_checkModel.token);
        UserPreferences.saveUserID(_checkModel.ID);
       Navigator.push(
            context, MaterialPageRoute(builder: (context) => SuccessScreen()));
        //moveToNextScreen(context);
      } else if (_checkModel.code == 410) {
        iPark.iParkSnackBar(
            context,
            "Zadaný kód expiroval!",
            iParkColors.materialRedA400);
      } else {
        iPark.iParkSnackBar(
            context,
            "Nespravný kód!",
            iParkColors.materialRedA400);
      }
    } catch (e) {
      Navigator.pop(context);
      iPark.iParkSnackBar(
          context,
          "Zlé internetové pripojenie!",
          iParkColors.materialRedA400);
    }
  }

  void moveToNextScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SuccessScreen()));
  }
}
