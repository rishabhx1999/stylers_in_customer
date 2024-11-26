import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_colors.dart';

class PageIndicator extends StatelessWidget {
  int length;
  int selectedIndex = 0;

  PageIndicator({Key? key, required this.selectedIndex, required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal ,
      itemCount: length,
        shrinkWrap: true,
        itemBuilder: (context,position){
        return AnimatedContainer(
          margin: EdgeInsets.only(left: 8),
          width: position == selectedIndex? 30:10,
          height: 8,
          decoration: BoxDecoration(
            color:  position == selectedIndex ? AppColors.kPrimaryDarkColor : AppColors.kPrimaryDarkColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24)
          ), duration: Duration(milliseconds: 300),
        );

        });
  }
}
