import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/Widgets/CustomDivider.dart';
import 'package:foody/Widgets/CustomRatingBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/Widgets/Loader.dart';

class PlaceReviewView extends StatelessWidget{
  String placeID;
  PlaceReviewView({this.placeID});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:  Column(
        children: <Widget>[
          CustomDivider(
            color: Colors.grey[200],
          ),
           Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("25 reviews",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  StatelessRatingBar(rating: 2.0, size: 20,)
                ],
              ),
            ),
          ),
          CustomDivider(
            color: Colors.grey[200],
          ),
          Expanded(
            child: Container(
              child: PlaceReviewList(
                placeID: placeID
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlaceReviewList extends StatelessWidget{
  String placeID;
  PlaceReviewList({this.placeID});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("resturant/$placeID/Rating").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoaderWidget();
        final int messageCount = snapshot.data.documents.length;
        return ListView.separated(
          key: PageStorageKey("list_data"),
          itemCount: messageCount,
          itemBuilder: (context, index){
            final DocumentSnapshot document = snapshot.data.documents[index];
            return PlaceReviewListItem(
              rate:double.parse(document["rate"]), 
              comment:document["comment"],
              name:document["name"],
              date:document["date"]
            );
          },
          separatorBuilder: (context,index){
            return SizedBox(height: 20.0,);
          },
        );
      }
    );
    /*return ListView.separated(
        itemBuilder: (context,index){
          return PlaceReviewListItem();
        },
        separatorBuilder: (context,index){
          return SizedBox(height: 20.0,);
        },
        itemCount: 10
    );*/
  }
}

class PlaceReviewListItem extends StatelessWidget{
  double rate;
  String comment;
  String name;
  String date;
  PlaceReviewListItem({this.rate,this.comment,this.name,this.date});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Container(

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                  child: Image.network("https://www.w3schools.com/howto/img_avatar.png"),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 40.0,
                width: 40.0,
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                      Text(date,style: TextStyle(fontSize: 13.0),)
                    ],
                  ),
                )
              ),
              StatelessRatingBar(rating: rate, size: 20,)
            ],
          ),
          Text(comment,
            style: TextStyle(fontSize: 13),
            maxLines: 3,
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}