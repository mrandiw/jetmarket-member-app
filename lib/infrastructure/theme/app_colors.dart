import 'package:flutter/material.dart';

const kMain = Color(0xFF232323);
const kBlack = Color(0xFF2D2D2D);
const kSoftBlack = Color(0xFF7B7B7B);
const kSofterBlack = Color(0xFFA3A3A3);
const kSoftGrey = Color(0xFFC5C5C5);
const kSofterGrey = Color(0xFFE5E5E5);
const kGrey = Color(0xFFBCBABA);
const kWhite = Color(0xFFFFFFFF);
const kWhiteBackground = Color(0xFFFFFAFA);
Color kBorder = const Color(0xFFA0A3BD).withOpacity(0.15);
Color kDivider = const Color(0xFFA0A3BD).withOpacity(0.3);

const kNormalColor = Color(0xFF3D7FFE);
const kNormalAccentColor = Color(0xFF0EC1E9);
const kNormalAccentColor2 = Color(0xFFEFF8FA);

const kNormalColor2 = Color(0xFFEFF0FA);

const kPrimaryColor = Color(0xffDB4C45);
const kPrimaryColor2 = Color(0xffFFF5F5);
const kPrimaryColor3 = Color(0xff0E203D);
const kPrimaryColor4 = Color(0xff173666);

const kSecondaryColor = Color(0xffED4C4D);
const kSecondaryColor2 = Color(0xffFFF5F5);
const kSecondaryColor3 = Color.fromARGB(255, 155, 3, 3);

const kAccentColor = Color(0xffF5F5F5);
const kBackgroundColor = Color(0xffFFF5F5);
const kErrorColor = Color(0xffED4C4D);
const kSuccessColor = Color(0xff19C85F);
const kSuccessColor2 = Color(0xffDAFFE9);

const kWarningColor = Color(0xffE8B61A);
const kWarning2Color = Color(0xffFFFAEB);

const kDisable = Color(0xffA0A3BD);
const kDisable2 = Color(0xffEFF0FA);





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jetmarket/infrastructure/theme/app_colors.dart';
// import 'package:jetmarket/utils/extension/responsive_size.dart';

// TextStyle get text20BlackSemiBold => GoogleFonts.poppins(
//       fontSize: 19.wr,
//       fontWeight: FontWeight.w600,
//       color: kBlack,
//     );
// TextStyle get text20PrimarySemiBold => GoogleFonts.poppins(
//       fontSize: 19.wr,
//       fontWeight: FontWeight.w600,
//       color: kPrimaryColor,
//     );
// TextStyle get text16BlackSemiBold => GoogleFonts.poppins(
//       fontSize: 15.wr,
//       fontWeight: FontWeight.w600,
//       color: kBlack,
//     );
// TextStyle get text16PrimarySemiBold => GoogleFonts.poppins(
//       fontSize: 15.wr,
//       fontWeight: FontWeight.w600,
//       color: kPrimaryColor,
//     );
// TextStyle get text14BlackRegular => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w400,
//       color: kBlack,
//     );
// TextStyle get text14PrimaryRegular => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w400,
//       color: kPrimaryColor,
//     );
// TextStyle get text14HintRegular => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xff808080),
//     );
// TextStyle get text12HintRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xff808080),
//     );
// TextStyle get text12WhiteRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kWhite,
//     );
// TextStyle get text8WhiteRegular => GoogleFonts.poppins(
//       fontSize: 7.wr,
//       fontWeight: FontWeight.w400,
//       color: kWhite,
//     );
// TextStyle get text14BlackMedium => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w500,
//       color: kBlack,
//     );

// TextStyle get text14BlackSemiBold => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w600,
//       color: kBlack,
//     );
// TextStyle get text14PrimarySemiBold => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w600,
//       color: kPrimaryColor,
//     );
// TextStyle get text12BlackSemiBold => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w600,
//       color: kBlack,
//     );
// TextStyle get text12BlackMedium => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w500,
//       color: kBlack,
//     );
// TextStyle get text12BlackRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kBlack,
//     );
// TextStyle get text12NormalRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kNormalColor,
//     );
// TextStyle get text12SucessRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kSuccessColor,
//     );
// TextStyle get text12PrimaryRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kPrimaryColor,
//     );
// TextStyle get text12PrimaryMedium => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w500,
//       color: kPrimaryColor,
//     );
// TextStyle get text12WarningMedium => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w500,
//       color: kWarningColor,
//     );
// TextStyle get text14WhiteSemiBold => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w600,
//       color: kWhite,
//     );
// TextStyle get text18WhiteSemiBold => GoogleFonts.poppins(
//       fontSize: 17.wr,
//       fontWeight: FontWeight.w600,
//       color: kWhite,
//     );
// TextStyle get text12HintForm => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xffA0A3BD),
//     );
// TextStyle get text10SuccessMedium => GoogleFonts.poppins(
//       fontSize: 9.wr,
//       fontWeight: FontWeight.w500,
//       color: kSuccessColor,
//     );
// TextStyle get text10HintRegular => GoogleFonts.poppins(
//       fontSize: 9.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xff626262),
//     );
// TextStyle get text10BlackRegular => GoogleFonts.poppins(
//       fontSize: 9.wr,
//       fontWeight: FontWeight.w400,
//       color: kBlack,
//     );
// TextStyle get text11NormalMedium => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w500,
//       color: kNormalColor,
//     );
// TextStyle get text11NormalAccentMedium => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w500,
//       color: kNormalAccentColor,
//     );
// TextStyle get text11HintMedium => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w500,
//       color: const Color(0xff808080),
//     );
// TextStyle get text11PrimaryRegular => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w400,
//       color: kPrimaryColor,
//     );
// TextStyle get text11HintRegular => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w400,
//       color: kBorder,
//     );

// TextStyle get text11GreyRegular => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xff8F8383),
//     );

// TextStyle get text12NormalAccentRegular => GoogleFonts.poppins(
//       fontSize: 11.wr,
//       fontWeight: FontWeight.w400,
//       color: kNormalAccentColor,
//     );

// TextStyle get text14NormalAccentRegular => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w400,
//       color: kNormalAccentColor,
//     );
// TextStyle get text14SuccessSemiBold => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w600,
//       color: kSuccessColor,
//     );

// TextStyle get text11SuccessRegular => GoogleFonts.poppins(
//       fontSize: 10.wr,
//       fontWeight: FontWeight.w400,
//       color: kSuccessColor,
//     );

// TextStyle get text10lineThroughRegular => GoogleFonts.poppins(
//       fontSize: 9.wr,
//       fontWeight: FontWeight.w500,
//       color: const Color(0xffA0A3BD),
//       decoration: TextDecoration.lineThrough,
//     );
// TextStyle get text14lineThroughRegular => GoogleFonts.poppins(
//       fontSize: 13.wr,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xffA0A3BD),
//       decoration: TextDecoration.lineThrough,
//     );
