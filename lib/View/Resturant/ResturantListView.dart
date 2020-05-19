import 'package:flutter/material.dart';
import 'package:foody/Theme/Color.dart';
import 'package:foody/Theme/CustomTextStyle.dart';
import 'package:foody/View/Resturant/ResturantDetail.dart';
import 'package:foody/Widgets/CustomOutlineButton.dart';
import 'package:foody/Widgets/Loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResturantListView extends StatelessWidget{
  
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (context, constraint) {
        double height = constraint.biggest.height;
        double width = constraint.biggest.width;
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("resturant").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LoaderWidget();
            final int messageCount = snapshot.data.documents.length;
            
            return ListView.separated(
              key: PageStorageKey("list_data"),
              itemCount: messageCount,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data.documents[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResturantDetail(
                          index: index, 
                          image: "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", 
                          title: document["name"],
                          placeID: document.documentID,
                        ),
                      ),
                    );
                  },
                  child: ResturantListItem(
                    width: width, 
                    height: height, 
                    index: index, 
                    name: document["name"], 
                    type: document["type"],
                    image: "https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  ),
                );
              },
              separatorBuilder: (context, index){
                return Container();
              },
            );
          }
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
            text: "Open in Google Map",
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
  ResturantListItem({this.width, this.height, this.index, this.name, this.type, this.image});

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