import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ipark_sharing/api/login_model.dart';
import 'package:ipark_sharing/models/home_model.dart';
import 'package:ipark_sharing/screens/auth/email_code_screen.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:ipark_sharing/widgets/textfield_widget.dart';
import 'package:ipark_sharing/widgets/wave_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

String emailController;

class HomeView extends StatelessWidget {
  LoginModel _loginCode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final model = Provider.of<HomeModel>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height - 200,
              color: iParkColors.mainTextColor,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -size.height / 3.2 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 2.3,
              color: iParkColors.mainBackGroundcolor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Poďme sharovať!",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                    textAlign: TextAlign.center,
                    style: iPark.mainHeaderTextStyle(
                        iParkColors.mainBackGroundcolor),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prihlásenie do aplikácie je bez registrácie. Stačí sa prihlásiť pomocou emailu.",
                  style: iPark.subtitleTextStyle(iParkColors.mainBackGroundcolor),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Email',
                        obscureText: false,
                        color: iParkColors.mainTextColor,
                        enabled: true,
                        imgAtributes: "atributes/open-email.png",
                        imgSuffix: model.isValid
                            ? "atributes/done.png"
                            : "atributes/close.png",
                        onChanged: (value) {
                          model.isValidEmail(value);
                          emailController = value;
                        },
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                iPark.iParkCustomButton(
                    color: iParkColors.mainTextColor,
                    context: context,
                    text: "prihlásiť sa".toUpperCase(),
                    onClicked: () async {
                      iPark.iParkLoadingDialog(context);
                      if (emailController == null ||
                          !EmailValidator.validate(emailController)) {
                        Navigator.pop(context);
                        iPark.iParkSnackBar(context, "Zadajte prosím správny formát e-mailu!",
                            iParkColors.materialRedA400);
                      } else {
                        try {
                          final LoginModel login =
                              await iPark.ApiCreateEmailCode(emailController);
                          _loginCode = login;
                          if (_loginCode == null) {
                            Navigator.pop(context);
                            iPark.iParkSnackBar(
                                context,
                                "Zlé internetové pripojenie!",
                                iParkColors.materialRedA400);
                          } else {
                            UserPreferences.saveUserEmail(emailController);
                            if (_loginCode.code == 200) {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EmailVerificationScreen(
                                        emailAddress: "",
                                      )));
                            } else {
                              Navigator.pop(context);
                              iPark.iParkSnackBar(
                                  context, "CHYBA",
                                  iParkColors.materialRedA400);
                            }
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          return iPark.iParkSnackBar(context,
                              "Zlé internetové pripojenie", iParkColors.materialRedA400);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}