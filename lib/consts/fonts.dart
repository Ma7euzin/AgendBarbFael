

import 'package:agendfael/consts/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSizes{
  static const size12 = 12.0, size14 = 14.0, size16 = 16.0, size18 = 18.0, size20 = 20.0, size22 = 22.0, size34 = 34.0; 
}

class AppStyles{
  static normal({required String title, Color color = Colors.black54, double? size, TextAlign alignment = TextAlign.left}){
    return title.text.size(size).color(color).align(alignment).make();
  }

  static bold({required String title, Color color = Colors.black,double? size = AppSizes.size16,TextAlign alignment = TextAlign.left}){
    return title.text.size(size).color(color).fontFamily(GoogleFonts.nunito.toString()).align(alignment).make();
  }
}