import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class StatefulRatingBar extends StatefulWidget {
  final double size;
  final double initialRating;
  final RatingCallback onRatingChanged;
  StatefulRatingBar({this.initialRating, this.size, this.onRatingChanged});
  createState() => _StatefulRatingBarState();
}

class _StatefulRatingBarState extends State<StatefulRatingBar>{

  double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RatingBar(
      onRatingChanged: widget.onRatingChanged,
      emptyIcon: Icons.star_border,
      filledIcon: Icons.star,
      filledColor: Colors.amberAccent,
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
      emptyIcon: Icons.star_border,
      filledIcon: Icons.star,
      filledColor: Colors.amberAccent,
      maxRating: 5,
      size: size,
      initialRating: rating,
    );
  }
}