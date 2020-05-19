import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/Modal/Validation.dart';
import 'package:foody/Theme/CustomTextStyle.dart';
import 'package:foody/Widgets/FormInputDecoration.dart';
import "package:google_maps_webservice/places.dart";
import 'package:foody/Modal/Restaurant.dart';

typedef void SearchCallback(PlacesSearchResponse res);

class SearchPlaceView extends StatefulWidget {
  final SearchCallback onSearchResult;
  SearchPlaceView({this.onSearchResult});
  State<SearchPlaceView> createState() => SearchPlaceViewState();
}

class SearchPlaceViewState extends State<SearchPlaceView> {
  final _formKey = GlobalKey<FormState>();
  
  String keyword;
  List<Restaurant> placeList = [];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                    onSaved: (val) => this.keyword = val,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.newline,
                    style: FormInputDecoration.CustomTextStyle(),
                    textAlign: TextAlign.left,
                    textCapitalization: TextCapitalization.none,
                    decoration: FormInputDecoration.FormInputDesign(name: "Keyword"),
                    validator: (value) => CheckFieldValidation(
                        val: value,
                        password: null,
                        fieldName: "Keyword",
                        fieldType: VALIDATION_TYPE.TEXT),
                )
              ),
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search place',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final places = GoogleMapsPlaces(apiKey: "AIzaSyBvaJ-Cdd8pc46GVivjnmGkSaECC0xZQqM");
                    PlacesSearchResponse response = await places.searchByText(this.keyword);
                    widget.onSearchResult(response);
                    setState(() {
                      this.placeList = response.results.map((res) => Restaurant(name: res.name, type: res.placeId)).toList();
                      print(this.placeList.length);
                    });
                  }
                },
              ),
            ]),
        )
      ),
      Expanded(child: LayoutBuilder(builder: (context, constraint) {
          final height = constraint.maxHeight;
          final width = constraint.maxWidth;
          return ListView.builder(
            itemCount: placeList.length,
            itemBuilder: (context, index) {
              return GestureDetector(child: SearchResultListItem(
                height: height,
                width: width,
                name: placeList[index].name,
                type: placeList[index].type
              ));
            },
          );
        })
      )
    ]);
  }

  _search(BuildContext context) {
    // TODO: do search
    _formKey.currentState.save();
  }
}

class SearchResultListItem extends StatelessWidget{

  final double height;
  final double width;
  final int index;
  final String name;
  final String type;
  SearchResultListItem({this.width, this.height, this.index, this.name, this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: height/10,
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: resturantListTitleText(),),
                Text(type, style: resturantListSubTitleText())
              ],
            ),
          ),
        ],
      ),
    );
  }
}