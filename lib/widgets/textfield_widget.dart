import 'package:flutter/material.dart';
import 'package:ipark_sharing/models/home_model.dart';
import 'package:ipark_sharing/utils/custom_style.dart';
import 'package:ipark_sharing/utils/img.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String imgAtributes;
  final String imgSuffix;
  final bool obscureText;
  final Function onChanged;
  final TextInputType keyBoard;
  final Color color;
  final bool enabled;

  TextFieldWidget(
      {this.hintText,
      this.imgAtributes,
      this.imgSuffix,
      this.obscureText,
      this.onChanged,
      this.keyBoard,
      this.color,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return TextField(
      keyboardType: keyBoard,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: color,
      style: TextStyle(
          color: color,
          fontSize: 18.0,
          fontFamily: 'Montserrat-Bold'),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: color,
            fontSize: 16,
            fontFamily: 'Montserrat-Bold'),
        focusColor: color,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(CustomStyle.cornerPadding),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CustomStyle.cornerPadding),
          borderSide: BorderSide(color: color),
        ),
        labelText: hintText,
        prefixIcon: CircleAvatar(
          child: Container(
            width: 25,
            height: 25,
            child: Image.asset(
                Img.get(imgAtributes),
                fit: BoxFit.cover),
          ),
          backgroundColor: Colors.transparent,
        ),
        enabled: enabled,
        suffixIcon: (imgSuffix != null) ? GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: CircleAvatar(
            child: Container(
              width: 15,
              height: 15,
              child: Image.asset(
                  Img.get(imgSuffix),
                  fit: BoxFit.cover),
            ),
            backgroundColor: Colors.transparent,
          ),
        ) : Container(width: 0,),
      ),
    );
  }
}
