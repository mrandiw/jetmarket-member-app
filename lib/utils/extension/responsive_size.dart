import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AdaptiveSizeExtension on num {
  double get hr {
    return (this / 800) * ScreenUtil().screenHeight;
  }

  double get wr {
    return (this / 360) * ScreenUtil().screenWidth;
  }
}
