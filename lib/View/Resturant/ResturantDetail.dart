import 'package:flutter/material.dart';
import 'package:foody/Theme/Color.dart';
import 'package:foody/Theme/CustomTextStyle.dart';
import 'package:foody/Widgets/CustomOutlineButton.dart';
import 'package:foody/View/Resturant/MenuView.dart';
import 'package:foody/View/Resturant/PlaceDetailsView.dart';
import 'package:foody/View/Resturant/PlaceReviewView.dart';
import 'package:foody/View/Review/NewReview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class ResturantDetail extends StatefulWidget{
  int index;
  String image;
  String title;
  String placeID;

  ResturantDetail({this.index,this.image,this.title,this.placeID});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResturantDetailState(placeID: placeID);
  }
}

class ResturantDetailState extends State<ResturantDetail> with SingleTickerProviderStateMixin{

  String placeID;
  ResturantDetailState({this.placeID});

  TabController tabController;
  DetailsResult detailsResult;
  

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getDetils(this.placeID);
    tabController = TabController(length: 3,vsync: this,initialIndex: 0);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          InkResponse(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewReview(
                    resturantName: widget.title,
                    )
                  ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.note_add),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3.5,
            padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child: Hero(
              tag: widget.index,
              child: Image.network(widget.image),
            )
          ),
          CustomOutlineButton(
              onPressed: (){

              },
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
              textStyle: resturantListButton().copyWith(fontSize: 16.0),
              highlightColor: primaryColor,
              borderColor: primaryColor,
              text: "Ready in 20Min",
            ),
          Expanded(
            child: DetailTabView(tabController: tabController, placeID: widget.placeID, detailsResult: detailsResult),
          )
        ],
      )
    );
  }
  void getDetils(String placeID) async {
    var googlePlace = await GooglePlace('AIzaSyBvaJ-Cdd8pc46GVivjnmGkSaECC0xZQqM');
    var result = await googlePlace.details.get(placeID);
    setState(() {
        detailsResult = result.result;
      });
  }
}



class DetailTabView extends StatelessWidget{
  TabController tabController;
  String placeID;
  DetailsResult detailsResult;
  DetailTabView({this.tabController,this.placeID,this.detailsResult});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          child: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide.none
            ),
            labelStyle: TextStyle(color: primaryColor),
            unselectedLabelColor: greyColor,
            labelColor: primaryColor,
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(toUpper("Food menu"),style: detailsTabTitle(),),
              ),
              Tab(
                child: Text(toUpper("Place detail"),style: detailsTabTitle(),),
              ),
              Tab(
                child: Text(toUpper("Place review"),style: detailsTabTitle(),),
              )
            ],
          ),
          color: Colors.white,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              MenuView(placeID: placeID),
              PlaceDetailView(placeID: this.placeID,
              detailsResult: this.detailsResult,
              ),
              PlaceReviewView(placeID: placeID)
            ],
          ),
        )
      ],
    );
  }
}