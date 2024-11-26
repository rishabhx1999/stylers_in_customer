import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/reviews/reviews_controller.dart';

import '../../widgets/common/chip_widget.dart';
import '../../widgets/common/review_widget.dart';

class ReviewsScreen extends StatelessWidget {
  final _reviewsController = Get.put(ReviewsController());

  ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'all_reviews'.tr,
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 19.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(
              'your_review'.tr,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.black.withOpacity(0.67),
                  ),
            ),
          ),
          const SizedBox(
            height: 2.28,
          ),
          Center(
            child: Obx(
              () => RatingBar.builder(
                initialRating: _reviewsController.mStylistRating.value,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24.65,
                wrapAlignment: WrapAlignment.center,
                itemPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemBuilder: (context, index) => SvgPicture.asset(
                  AppIcons.ic_star,
                  height: 24.65,
                ),
                onRatingUpdate: (rating) {
                  _reviewsController.mStylistRating.value = rating;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 44.04,
          ),
          SizedBox(
            height: 26.0,
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 20.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChipWidget(
                      title: _reviewsController.chipOptions[index],
                      currentIndex: index,
                      selectedIndex: _reviewsController.selectedChipIndex,
                      onTap: _reviewsController.onChipTap);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 2.0,
                  );
                },
                itemCount: _reviewsController.chipOptions.length),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      endIndent: 273.0,
                      color: Colors.black.withOpacity(0.1),
                      height: 1.0,
                      thickness: 1.0,
                    ),
                    const SizedBox(
                      height: 18.0,
                    )
                  ],
                );
              },
              itemBuilder: (context, index) {
                return const ReviewWidget();
              }),
          const SizedBox(
            height: 19.0,
          )
        ],
      )),
    );
  }
}
