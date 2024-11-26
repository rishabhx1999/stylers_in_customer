import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';

class CommonServiceWidgetShimmer extends StatelessWidget {
  const CommonServiceWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Shimmer.fromColors(
        //   baseColor: AppColors.shimmerBaseColor,
        //   highlightColor: AppColors.shimmerHighlightColor,
        //   child:
        Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        width: 98.0,
        height: 87.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        // constraints: const BoxConstraints(
        //   maxWidth: 98,
        //   maxHeight: 87,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 32.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.shimmerBaseColor,
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 10,
                  width: 50,
                  decoration: BoxDecoration(color: AppColors.shimmerBaseColor),
                ))
          ],
        ),
      ),
    );
  }
}
