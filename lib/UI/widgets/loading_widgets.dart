
import 'package:flutter/material.dart';


Widget loadingWidget(BuildContext context){
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).progressIndicatorTheme.circularTrackColor!),
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}

Widget loadingList(BuildContext context){
  return Positioned(
    bottom: 50,
    left: MediaQuery.of(context).size.width / 2 - 25.0,
    child: Align(
      alignment: Alignment.center,
      child: loadingWidget(context),
    ),
  );
}