import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

class SelectedRating extends StatefulWidget {
  final Function(int)? onChanged;

  const SelectedRating({Key? key, this.onChanged}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectedRatingState createState() => _SelectedRatingState();
}

class _SelectedRatingState extends State<SelectedRating> {
  int _rating = 0;

  void _updateRating(int index) {
    setState(() {
      if (_rating == index) {
        _rating = 0;
      } else {
        _rating = index;
      }
    });

    widget.onChanged?.call(_rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        IconData iconData = Icons.star;
        if (_rating >= index + 1) {
          iconData = Icons.star_rounded;
        } else {
          iconData = Icons.star_border_rounded;
        }

        return GestureDetector(
          onTap: () {
            _updateRating(index + 1);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Icon(
              iconData,
              color: kWarningColor,
              size: 26.r,
            ),
          ),
        );
      }),
    );
  }
}
