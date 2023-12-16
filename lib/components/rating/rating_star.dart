import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfFilledStars = rating.floor();
    double fraction = rating - numberOfFilledStars;

    bool hasHalfStar = fraction >= 0.5;
    bool showEmptyStar = fraction < 0.5 && fraction > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < numberOfFilledStars) {
          return Icon(
            Icons.star,
            size: 18.r,
            color: kWarningColor,
          );
        } else if (index == numberOfFilledStars && hasHalfStar) {
          return Stack(
            children: [
              Icon(
                Icons.star,
                size: 18.r,
                color: kSofterGrey,
              ),
              ClipRect(
                clipper: FractionalClip(fraction),
                child: Icon(
                  Icons.star,
                  size: 18.r,
                  color: kWarningColor,
                ),
              ),
            ],
          );
        } else if (index == numberOfFilledStars && showEmptyStar) {
          return Icon(
            Icons.star,
            size: 18.r,
            color: kSofterGrey,
          );
        } else {
          return Icon(
            Icons.star,
            size: 18.r,
            color: kSofterGrey,
          );
        }
      }),
    );
  }
}

class FractionalClip extends CustomClipper<Rect> {
  final double fraction;

  FractionalClip(this.fraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(FractionalClip oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
