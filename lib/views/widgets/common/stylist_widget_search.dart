import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

import '../../../model/search/search_res_model.dart';

class StylistWidgetSearch extends StatelessWidget {
  StylistWidgetSearch({Key? key, required this.user, required this.onTab})
      : super(key: key);

  Function(Provider user) onTab;
  Provider user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab(user);
      },
      child: Container(margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.fromLTRB(15.0, 8.0, 11.48, 13),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage(AppImages.imgUserPlaceholder),
              foregroundImage:
                  user.avatar != null ? NetworkImage(user.avatar!) : null,
              radius: 22,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          user.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      AbsorbPointer(
                        child: RatingBar.builder(
                          initialRating: double.parse(user.ratingAvg ?? '0'),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10,
                          wrapAlignment: WrapAlignment.center,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => SvgPicture.asset(
                            AppIcons.ic_star,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),
                  Text(
                    user.role ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0x99000000)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.locationPink,
                        height: 11.68,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(user.address1 ?? 'not_available'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: AppConsts.commonFontSizeFactor * 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              )),
                      const Expanded(child: SizedBox()),
                      // Visibility(
                      //   visible: user.rate != null && user.rate != '',
                      //   child: Text("\$${user.rate ?? ''}",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline6
                      //           ?.copyWith(
                      //             fontSize: AppConsts.commonFontSizeFactor * 14,
                      //             color: AppColors.kPrimaryDarkColor,
                      //           )),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
