import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ethan loyd',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 12),
        ),
        Text(
          '@ethan54',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black.withOpacity(0.50),
              fontSize: AppConsts.commonFontSizeFactor * 12),
        ),
        const SizedBox(
          height: 3.0,
        ),
        RatingBar.builder(
          initialRating: 5.0,
          minRating: 0.5,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 11.77,
          wrapAlignment: WrapAlignment.center,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, index) => SvgPicture.asset(
            AppIcons.ic_star,
            height: 11.77,
          ),
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(
          height: 3.23,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 12),
        ),
      ],
    );
  }
}
