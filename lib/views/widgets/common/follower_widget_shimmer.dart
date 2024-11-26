import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';

class FollowerWidgetShimmer extends StatelessWidget {
  const FollowerWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 41.0,
                  width: 41.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.shimmerBaseColor,
                  ),
                )),
            const SizedBox(
              width: 10.0,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(
                    height: 12.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: AppColors.shimmerBaseColor,
                    ),
                  )),
              const SizedBox(
                height: 2.0,
              ),
              Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(
                    height: 12.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: AppColors.shimmerBaseColor,
                    ),
                  )),
            ]),
            // CommonButtonOutline(
            //   backgroundColor: Theme.of(context).backgroundColor,
            //   borderWidth: 2.0,
            //   width: 112.0,
            //   height: 28.0,
            //   borderRadius: 2.0,
            //   textColor: AppColors.kPrimaryColor,
            //   text: 'unfollow',
            //   clickAction: () {},
            // )
          ]),
    );
  }
}
