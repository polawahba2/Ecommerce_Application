import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/Shared/CasheHelper.dart';

var kAppBarColor = Color(0xFF6F35A5);
var kSystemStutusBar = Colors.deepPurple[700];
var kPrimaryLightColor = Color(0xFFF1E6FF);

const kPrimaryColor = Colors.blueAccent;
const kTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.w900,
);
var kSizedBoxHight = 0.02;

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCESS, ERROR, WARRNING }

Color ChooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.SUCESS:
      color = Colors.green;
      break;
    case ToastStates.WARRNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void pushOnly({context, var route}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void pushAndTerminate({context, var route}) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void signOut(context) {
  CashHelper.removeKey(key: 'token').then((value) {
    pushAndTerminate(context: context, route: LogInScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
