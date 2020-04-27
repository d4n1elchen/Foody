import 'package:flutter/material.dart';

class PlaceDetailView extends StatelessWidget{
  String placeID;
  PlaceDetailView({this.placeID});
  @override

  Widget build(BuildContext context) {
    // TODO: implement build

    return Center(
      child: Text(placeID),
    );
  }
}