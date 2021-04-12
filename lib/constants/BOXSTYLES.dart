import 'package:flutter/material.dart';

Widget shadowButton({
  Color color,
  Color bordercolor,
  double bradius,
  String bText,
  double bTextSize,
  FontWeight bTextWeight,
  double shadow,
}) {
  color = color == null ? Color(0xFFC4C4C4) : color;
  bordercolor = bordercolor == null ? color : bordercolor;
  bradius = bradius == null ? 0.0 : bradius;
  bText = bText == null ? " " : bText;
  bTextSize = bTextSize == null ? 16.0 : bTextSize;
  bTextWeight = bTextWeight == null ? FontWeight.w400 : bTextWeight;
  shadow = shadow == null ? 0.0 : shadow;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(bradius),
      ),
      color: color,
      border: Border.all(color: bordercolor),
      boxShadow: kElevationToShadow[shadow],
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      child: Text(
        bText,
        style: TextStyle(
          fontSize: bTextSize,
          fontWeight: bTextWeight,
          color: Colors.black,
        ),
      ),
    ),
  );
}
String dummyImageUrl = "https://i2-prod.belfastlive.co.uk/incoming/article12963211.ece/ALTERNATES/s1200c/Dominos-Pizza.jpg";

InputDecoration inputFieldDec = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
InputDecoration searchDec =
    InputDecoration(border: InputBorder.none, hintText: "Search");
