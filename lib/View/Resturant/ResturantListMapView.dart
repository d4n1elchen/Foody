import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResturantMapView extends StatefulWidget {
  @override
  State<ResturantMapView> createState() => ResturantMapViewState();
}

class ResturantMapViewState extends State<ResturantMapView> with AutomaticKeepAliveClientMixin<ResturantMapView>, TickerProviderStateMixin{
  Completer<GoogleMapController> _controller = Completer();

  Animation animation;
  AnimationController animationController;
  Animation offset;
  
  double fromBottom = 0;

  @override
  void initState() {
    super.initState();
    
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.0,end: 250.0)
                .animate(CurvedAnimation(parent: animationController, curve: Curves.ease));

    offset = Tween<Offset>(begin: Offset(0.0,1.0), end: Offset(0.0, 0.0))
             .animate(animationController);

    animation.addListener((){
      setState((){});
    });

    offset.addListener((){
    });
  }

  @override
  bool get wantKeepAlive => true;   //by default it will be null, change it to true.

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
            bottom: animation.value,
            child: Align(
              alignment: Alignment.center,
              child: SafeArea(
                bottom: (animation.value == 0) ? true : false,
                minimum: EdgeInsets.only(bottom: 10.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: (){
                          if(fromBottom == 100){
                            animationController.reverse();
                            setState(() {
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
          child: SlideTransition(
            position: offset,
            child: Container(
              height: 250.0,
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Search",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[200]))),
                  ),
                  Expanded(
                    child: Text("這裡會放個搜尋 Bar"),//SearchPlaceView(),
                  )
                ],
              ),
            )
          ),
        )
      ]),
    );
  }

  ///
  /// Blur widget while open filter
  ///
  getBlurWidget(){
    return (animation.value > 0) ? GestureDetector(
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