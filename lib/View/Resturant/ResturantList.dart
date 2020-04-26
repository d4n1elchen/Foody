import 'package:flutter/material.dart';
import 'package:foody/Theme/Color.dart';
import 'package:foody/Theme/CustomTextStyle.dart';
import 'package:foody/View/Resturant/ResturantListMapView.dart';
import 'ResturantListView.dart';


class ResturantList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResturantListState();
  }
}

class ResturantListState extends State<ResturantList> with TickerProviderStateMixin{

  int activeView = 0;
  EdgeInsets padding = EdgeInsets.symmetric(horizontal:10.0,vertical: 15.0);
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this,length: 2,initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                isScrollable: false,
                unselectedLabelColor: greyColor,
                labelColor: primaryColor,
                tabs: <Widget>[
                  Tab(
                    child: Text("Resturant List"),
                  ),
                  Tab(
                    child: Text("Resturant Map"),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: <Widget>[
                    ResturantListView(),
                    ResturantMapView()
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}