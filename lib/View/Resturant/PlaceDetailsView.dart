import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class PlaceDetailView extends StatelessWidget{
  String placeID;
  DetailsResult detailsResult;
  PlaceDetailView({this.placeID,this.detailsResult});
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    
      return Center(
        child: Text(detailsResult.formattedAddress),
      );
    
    
  }
}