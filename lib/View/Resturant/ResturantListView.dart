import 'package:flutter/material.dart';
import 'package:foody/Theme/Color.dart';
import 'package:foody/Theme/CustomTextStyle.dart';
import 'package:foody/View/Resturant/ResturantDetail.dart';
import 'package:foody/Widgets/CustomOutlineButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/Modal/resturants.dart';

class ResturantListView extends StatelessWidget{
  @override

  List<ResturantData> rList = [];

  var cnt = -1;

  void initState(){
    DatabaseReference resturantRef = FirebaseDatabase.instance.reference().child("resturant");
    resturantRef.once().then((DataSnapshot snap){
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      rList.clear();
      for(var individualKey in KEYS){
        ResturantData res = new ResturantData(
          DATA[individualKey]['name'],
          DATA[individualKey]['type'],
          DATA[individualKey]['placeID'],
        );
        rList.add(res);
      }
    });
  }
  
  Widget build(BuildContext context) {
    // TODO: implement build
    DatabaseReference resturantRef = FirebaseDatabase.instance.reference().child("resturant");
    resturantRef.once().then((DataSnapshot snap){
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      rList.clear();
      for(var individualKey in KEYS){
        ResturantData res = new ResturantData(
          DATA[individualKey]['name'],
          DATA[individualKey]['type'],
          DATA[individualKey]['placeID'],
        );
        rList.add(res);
      }
    });
    cnt++;
    return LayoutBuilder(
      builder: (context,constraint){

        double height = constraint.biggest.height;
        double width = constraint.biggest.width;
        return ListView.separated(
          key: PageStorageKey("list_data"),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResturantDetail(
                        index: index, 
                        image: "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", 
                        title: "Hello!",
                      ),
                    ),
                );
              },
              child: ResturantListItem(
                width: width, 
                height: height, 
                index: index, 
                name: rList[cnt].name, 
                type: rList[cnt].type,
                image: "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              ),
            );
          },
          separatorBuilder: (context,index){
            return Container();
          },
          itemCount: rList.length,
        );
      },
    );
  }
}

class TextSection extends StatelessWidget{
  final String name;
  final String type;
  TextSection({this.name,this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,style: resturantListTitleText(),),
                Text(type,style: resturantListSubTitleText())
              ],
            ),
          ),
        ),
        Container(
          child: CustomOutlineButton(
          onPressed: (){

          },
          textStyle: resturantListButton(),
          highlightColor: primaryColor,
          borderColor: primaryColor,
          text: "Ready in 20Min",
          ),
        ),
      ],
    );
  }
}

class ResturantListItem extends StatelessWidget{

  final double height;
  final double width;
  final int index;
  final String name;
  final String type;
  final String image;
  ResturantListItem({this.width,this.height,this.index,this.name,this.type,this.image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: height/3,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Hero(
                tag: index,
                child: Container(
                  width: width-20,
                  child: Image.network(image, fit: BoxFit.fitWidth,),
                ),
              )
          ),
          TextSection(name: name, type: type)
        ],
      ),
    );
  }
}