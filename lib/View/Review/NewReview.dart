import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:foody/Widgets/PageHeader.dart';
import 'package:foody/Widgets/CustomButton.dart';
import 'package:foody/Widgets/FormInputDecoration.dart';
import 'package:foody/Widgets/CustomRatingBar.dart';
import 'package:foody/Modal/Validation.dart';
import 'package:foody/Modal/Authentication.dart';

class NewReview extends StatefulWidget {
  final String resturantName;
  NewReview({this.resturantName});
  createState() => NewReviewState();
}

class NewReviewState extends State<NewReview> {
  Authentication _authentication;

  double rating;
  String review;

  FocusNode _reviewFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _autoValid = false;

  @override
  void initState() {
    super.initState();

    _authentication = Authentication();
    rating = 0;

    _autoValid = false;
  }

  @override
  void dispose() {
    super.dispose();
    _reviewFocus?.unfocus();
  }

  _submit(BuildContext context) async {
    _reviewFocus.unfocus();

    setState(() => _autoValid = true);
    if (_formKey.currentState.validate()) {
      // TODO: implement submit review
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Builder(builder: (context) {
          return Stack(
            children: <Widget>[
              reviewForm(context),
            ],
          );
        })));
  }

  Widget reviewForm(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      autovalidate: _autoValid,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            PageHeader(title: "Post a new review"),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              enabled: false,
              initialValue: widget.resturantName,
              textInputAction: TextInputAction.next,
              style: FormInputDecoration.CustomTextStyle(),
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.none,
              decoration: FormInputDecoration.FormInputDesign(name: "Resturant Name"),
            ),
            SizedBox(
              height: 20.0,
            ),
            RatingFormField(
              onSaved: (value) => this.rating = value,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              maxLines: 10,
              onSaved: (val) => this.review = val,
              keyboardType: TextInputType.emailAddress,
              focusNode: _reviewFocus,
              textInputAction: TextInputAction.newline,
              style: FormInputAreaDecoration.CustomTextStyle(),
              textAlign: TextAlign.left,
              textCapitalization: TextCapitalization.none,
              decoration: FormInputAreaDecoration.FormInputAreaDesign(name: "Review"),
              validator: (value) => CheckFieldValidation(
                  val: value,
                  password: null,
                  fieldName: "Review",
                  fieldType: VALIDATION_TYPE.TEXT),
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              text: "Submit",
              color: Colors.green,
              onPressed: () => _submit(context),
            ),
          ],
        ),
      ),
    ));
  }
}

class RatingFormField extends FormField<double> {
  RatingFormField({
    FormFieldSetter<double> onSaved,
    FormFieldValidator<double> validator,
    double initialValue = 0,
    bool autovalidate = false
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autovalidate,
    builder: (FormFieldState<double> state) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Rating "),
          StatefulRatingBar(
            size: 25,
            onRatingChanged: (rating) {
              state.didChange(rating);
            },
          ),
        ],
      );
    }
  );
}