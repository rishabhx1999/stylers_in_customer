import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_place/google_place.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';

class SearchAddressWidget extends StatelessWidget {



  AutocompletePrediction place;
  VoidCallback? onClick;
   SearchAddressWidget({
    Key? key,
   required this.place,
     this.onClick
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          SvgPicture.asset(AppIcons.ic_navigation,width: 18,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(place.description??"",style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor *15,
                color: AppColors.color_8A
              ),),
            ),
          ),
          SvgPicture.asset(AppIcons.ic_next,width: 18,),

        ],),
      ),
    );
  }
}
