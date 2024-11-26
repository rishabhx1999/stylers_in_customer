import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/app_colors.dart';

class ShopWidgetShimmer extends StatelessWidget {
  const ShopWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Container(
          height: 200.0,
          width: 157.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.shimmerBaseColor,
          ),
        ));
  }
}
