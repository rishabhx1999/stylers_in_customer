import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';

class CommonStylistWidgetShimmer extends StatelessWidget {
  const CommonStylistWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.shimmerBaseColor,
          ),
        ));
  }
}
