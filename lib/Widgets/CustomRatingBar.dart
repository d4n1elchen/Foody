import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class StatefulRatingBar extends StatefulWidget {
  final double size;
  final RatingCallback onRatingChanged;
  StatefulRatingBar({this.size, this.onRatingChanged});
  createState() => _StatefulRatingBarState();
}

class _StatefulRatingBarState extends State<StatefulRatingBar>{

  double rating;

  @override
  void initState() {
    super.initState();
    rating = 3;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RatingBar(
      onRatingChanged: widget.onRatingChanged,
      isHalfAllowed: true,
      emptyIcon: Icons.star_border,
      filledIcon: Icons.star,
      filledColor: Colors.amberAccent,
      halfFilledIcon: Icons.star_half,
      maxRating: 5,
      size: widget.size,
      initialRating: rating,
    );
  }
}

class StatelessRatingBar extends StatelessWidget{

  final double rating;
  final double size;
  StatelessRatingBar({this.rating, this.size});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RatingBar.readOnly(
      isHalfAllowed: true,
      emptyIcon: Icons.star_border,
      filledIcon: Icons.star,
      filledColor: Colors.amberAccent,
      halfFilledIcon: Icons.star_half,
      maxRating: 5,
      size: size,
      initialRating: rating,
    );
  }
}