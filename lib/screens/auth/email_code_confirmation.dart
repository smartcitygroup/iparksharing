import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ipark_sharing/api/login_model.dart';
import 'package:ipark_sharing/utils/colors.dart';
import 'package:ipark_sharing/utils/constant.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/dimensions.dart';
import 'package:ipark_sharing/utils/ipark.dart';
import 'package:ipark_sharing/utils/user_preferences.dart';
import 'package:provider/provider.dart';

class EmailConfirmation extends StatefulWidget {
  final String title;
  final String subTitle;
  final String image;
  final String phoneNumber;
  final Future<String> Function(String) validateOtp;
  final void Function(BuildContext) routeCallback;
  Color topColor;
  Color bottomColor;
  bool _isGradientApplied;
  final Color titleColor;
  final Color themeColor;
  final Color keyboardBackgroundColor;
  final Widget icon;

  /// default [otpLength] is 4
  final int otpLength;

  EmailConfirmation({
    Key key,
    this.title = "Overovací kód",
    this.subTitle = "prosím zadajte kód ktorý sme vám poslali\n na váš e-mail.",
    this.otpLength = 6,
    @required this.validateOtp,
    @required this.routeCallback,
    this.themeColor = Colors.black,
    this.titleColor = Colors.black,
    this.icon,
    this.keyboardBackgroundColor,
    this.image,
    this.phoneNumber,
  }) : super(key: key) {
    this._isGradientApplied = false;
  }

  EmailConfirmation.withGradientBackground(
      {Key key,
      this.title = "Overovací kód",
      this.subTitle =
          "prosím zadajte kód ktorý sme vám poslali\n na váš e-mail.",
      this.otpLength = 6,
      @required this.validateOtp,
      @required this.routeCallback,
      this.themeColor = Colors.white,
      this.titleColor = Colors.white,
      @required this.topColor,
      @required this.bottomColor,
      this.keyboardBackgroundColor,
      this.icon,
      this.image,
      this.phoneNumber})
      : super(key: key) {
    this._isGradientApplied = true;
  }

  @override
  _EmailConfirmationState createState() => new _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation>
    with SingleTickerProviderStateMixin {
  Size _screenSize;
  int _currentDigit;
  List<int> otpValues;
  bool showLoadingButton = false;
  bool isPressed = false;
  bool canAgainSend = true;
  LoginModel _loginModel;

  @override
  void initState() {
    otpValues = List<int>.filled(widget.otpLength, null, growable: false);
    super.initState();
  }

  startAgainSend() async {
    var duration = new Duration(seconds: 30);
    return new Timer(duration, activateAgainSend);
  }

  void activateAgainSend() {
    setState(() {
      canAgainSend = true;
      isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
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
                      "Verifikácia",
                      style: iPark.appBarTextStyle(
                          Colors.white),
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
            child: _getInputPart,
          ),
        ));
  }

  /// Return "OTP" input fields
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getOtpTextWidgetList(),
    );
  }

  /// Returns otp fields of length [widget.otpLength]
  List<Widget> getOtpTextWidgetList() {
    // ignore: deprecated_member_use
    List<Widget> optList = List();
    for (int i = 0; i < widget.otpLength; i++) {
      optList.add(_otpTextField(otpValues[i]));
    }
    return optList;
  }

  /// Returns Otp screen views
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.subTitle,
                style: iPark.subtitleTextStyle(iParkColors.mainTextColor),
                textAlign: TextAlign.justify,
              ),
              heightSpace,
              ActionChip(
                label: Text((isPressed)
                    ? "Generovanie nového kódu..".toUpperCase()
                    : "Odoslať nový kód".toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),),
                padding: const EdgeInsets.all(5.0),
                backgroundColor: iParkColors.mainTextColor,
                labelPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                avatar: (isPressed)
                    ? CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.pink),
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                )
                    : null,
                onPressed: () async {
                  if (canAgainSend) {
                    if (!isPressed) {
                      setState(() {
                        isPressed = true;
                        canAgainSend = false;
                      });
                      try {
                        final LoginModel login = await iPark.ApiCreateEmailCode(
                            UserPreferences.getSaveUserEmail());
                        setState(() {
                          _loginModel = login;
                        });
                        if (_loginModel.code == 200) {
                          setState(() {
                            isPressed = false;
                          });
                          startAgainSend();
                          iPark.iParkSnackBar(
                              context,
                              "Odoslali sme na váš mail nový kód",
                              iParkColors.materialGreenA400);
                        }
                      } catch (e) {
                        startAgainSend();
                        setState(() {
                          isPressed = false;
                        });
                        return iPark.iParkSnackBar(
                            context,
                            "Zlé internetové pripojenie!",
                            iParkColors.materialRedA400);
                      }
                    }
                  } else {
                    iPark.iParkSnackBar(
                        context,
                       "Počkajte prosím pár sekúnd na generovanie nového kódu!", iParkColors.materialYellowA400);
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: _getInputField,
        ),
        showLoadingButton
            ? Container(
                width: 0,
                height: 0,
              )
            : Container(
                width: 0,
                height: 0,
              ),
        _getOtpKeyboard
      ],
    );
  }

  /// Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        color: widget.keyboardBackgroundColor,
        height: _screenSize.width,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {
                      _setCurrentDigit(4);
                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {
                      _setCurrentDigit(5);
                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {
                      _setCurrentDigit(6);
                    }),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {
                      _setCurrentDigit(7);
                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {
                      _setCurrentDigit(8);
                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {
                      _setCurrentDigit(9);
                    }),
              ],
            ),
            Flexible(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: widget.themeColor,
                      ),
                      onPressed: () {
                        setState(() {
                          for (int i = widget.otpLength - 1; i >= 0; i--) {
                            if (otpValues[i] != null) {
                              otpValues[i] = null;
                              break;
                            }
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Returns "Otp text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: widget.titleColor,),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                width: 3.0,
                color: widget.titleColor,
      ))),
    );
  }

  /// Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: widget.themeColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }
  /// sets number into text fields n performs
  ///  validation after last number is entered
  void _setCurrentDigit(int i) async {
    setState(() {
      _currentDigit = i;
      int currentField;
      for (currentField = 0; currentField < widget.otpLength; currentField++) {
        if (otpValues[currentField] == null) {
          otpValues[currentField] = _currentDigit;
          break;
        }
      }
      if (currentField == widget.otpLength - 1) {
        showLoadingButton = true;
        String otp = otpValues.join();
        widget.validateOtp(otp).then((value) {
          showLoadingButton = false;
          if (value == null) {
            //widget.routeCallback(context);
          } else if (value.isNotEmpty) {
            clearOtp();
          }
        });
      }
    });
  }

  ///to clear otp when error occurs
  void clearOtp() {
    otpValues = List<int>.filled(widget.otpLength, null, growable: false);
    setState(() {});
  }

}
