import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/model/search/search_model.dart';

import '../../../model/login/login_res_model.dart';
import '../../../model/search/search_res_model.dart';

class CommonShopListWidget extends StatelessWidget {
  CommonShopListWidget({Key? key,
    required this.onTap,
    required this.shopOwner})
      : super(key: key);
  Provider shopOwner;
  Function(Provider shop) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(shopOwner);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.48, 8),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(AppImages.img_shop),
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
                          shopOwner.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      RatingBar.builder(
                        initialRating: 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 10,
                        wrapAlignment: WrapAlignment.center,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => SvgPicture.asset(
                          AppIcons.ic_star,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                  Text(
                    'Hair Stylist',
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
                      Text('Location, of the, stylist.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: AppConsts.commonFontSizeFactor * 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              )),
                      const Expanded(child: SizedBox()),
                      Text(r"$$",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: AppConsts.commonFontSizeFactor * 14,
                                color: AppColors.kPrimaryDarkColor,fontWeight: FontWeight.w500,
                              )),
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
