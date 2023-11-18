import 'package:flutter/material.dart';

const Color kPrimaryGreen = Color(0xffD8FFB1);

const kHeadingStyle = TextStyle(fontFamily: "RobotoMono", fontSize: 32);

var kGreenBoxDecoration = BoxDecoration(
  color: Color(0xffD8FFB1),
  borderRadius: BorderRadius.circular(15),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.shade600,
      offset: const Offset(
        5.0,
        5.0,
      ),
      blurRadius: 3.0,
      spreadRadius: 0.5,
    ), //BoxShadow
  ],
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
