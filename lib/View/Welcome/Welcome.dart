import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/View/Resturant/ResturantList.dart';
import 'package:foody/View/Home/Home.dart';
import 'package:foody/Theme/Color.dart';

class Welcome extends StatelessWidget {
  FirebaseUser user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Welcome({this.user});

  logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Resturant Nearby"),
        backgroundColor: primaryColor,
      ),
      drawer: drawer(),
      body: ResturantList(),
    );
  }

  Drawer drawer(){
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child:Text("Foodsy",style: TextStyle(color: primaryColor,fontSize: 30.0),),
            ),
            drawerMenu(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Barcelona, Spain",style: TextStyle(fontSize: titleText,color: secondryColor),),
                  SizedBox(height: 5.0,),
                  Text("Change",style: TextStyle(color: primaryColor,fontSize: normalText),),
                ],
              )
            ),
          ],
        ),
      )
    );
  }

  Widget drawerMenu(){
    return Column(
      children: <Widget>[
        drawerList(active: true,icon: Icons.home,name:"Home",id: "HOME"),
        drawerList(active: false,icon: Icons.bookmark_border,name:"My Orders",id: "MY_ORDER"),
        drawerList(active: false,icon: Icons.notifications_none,name:"Notifications",id: "NOTIFICATION"),
        drawerList(active: false,icon: Icons.settings,name:"Settings",id: "SETTING"),
        drawerList(active: false,icon: Icons.power_settings_new,name:"Log Out",id: "LOGOUT"),
      ],
    );
  }

  Widget drawerList({String name,IconData icon,bool active,String id}){
      return InkWell(
        onTap: (){
          if(id == "LOGOUT"){
            logout(_scaffoldKey.currentContext);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
          child: Row(
            children: <Widget>[
              Icon(icon,color: active ? primaryColor : secondryColor,size: titleText,),
              SizedBox(width: 10.0,),
              Text(name,style: TextStyle(color: active ? primaryColor : secondryColor,fontSize: titleText),)
            ],
          ),
        ),
      );
  }

}
