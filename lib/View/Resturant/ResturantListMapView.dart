import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:foody/View/Resturant/SearchPlaceView.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResturantMapView extends StatefulWidget {
  @override
  State<ResturantMapView> createState() => ResturantMapViewState();
}

class ResturantMapViewState extends State<ResturantMapView> with AutomaticKeepAliveClientMixin<ResturantMapView>, TickerProviderStateMixin{
  Completer<GoogleMapController> _controller = Completer();
  
  double fromBottom = 0;
  double panelPos = 100.0;

  Animation animation;
  Animation sizeFactor;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.0, end: panelPos)
                .animate(CurvedAnimation(parent: animationController, curve: Curves.ease));
    sizeFactor = Tween<double>(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(parent: animationController, curve: Curves.ease));
  }

  @override
  bool get wantKeepAlive => true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        getBlurWidget(),
        Positioned(
            bottom: 0,
            child: Align(
              alignment: Alignment.center,
              child: SafeArea(
                bottom: true,
                minimum: EdgeInsets.only(bottom: 10.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: (){
                          if(fromBottom == 100){
                            animationController.reverse();
                            setState((){
                              fromBottom = 0;
                            });
                          }else{
                            setState(() {
                              fromBottom = 100;
                            });
                            animationController.forward();
                          }
                        },
                        child: Icon(Icons.search),
                      ),
                    )
                ),
              ),
            )
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizeTransition(
            sizeFactor: sizeFactor,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight - 100.0,
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Search", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[200]))),
                      ),
                      Expanded(
                        child: SearchPlaceView(
                          onSearchResult: (res) {
                            //animationController.forward();
                          }
                        ),
                      )
                    ],
                  ),
                );
              })
          ),
        )
      ]),
    );
  }

  ///
  /// Blur widget while open filter
  ///
  getBlurWidget(){
    return (fromBottom > 0) ? GestureDetector(
      onTap: (){
        print("TAP OUT SIDE");
        animationController.reverse();
        setState(() {
          fromBottom = 0;
        });
      },
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ) : Container();
  }
}