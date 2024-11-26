import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

import '../../../model/login/login_res_model.dart';

class CommonShopGridWidget extends StatelessWidget {
  CommonShopGridWidget({Key? key, required this.shopOwner, required this.onTap})
      : super(key: key);
  Function(User user) onTap;
  User shopOwner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(shopOwner);
      },
      child: Container(
        width: 157,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    topLeft: Radius.circular(4.0)),
                child: shopOwner.avatar != null && shopOwner.avatar != ''
                    ? FadeInImage.assetNetwork(
                        placeholder: AppImages.imgPlaceholder,
                        image: shopOwner.avatar!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.asset(
                        AppImages.imgPlaceholder,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ) /*Image.asset(
                  AppImages.img_shop,
                  width: double.infinity,
                  fit: BoxFit.fill,
                )*/
                ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Text(
                shopOwner.name ?? '',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Text(
                shopOwner.aboutUs ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: AppConsts.commonFontSizeFactor * 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: AbsorbPointer(
                child: RatingBar.builder(
                  initialRating: shopOwner.ratingAverage?.toDouble() ?? 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  wrapAlignment: WrapAlignment.center,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => SvgPicture.asset(
                    AppIcons.ic_star,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppIcons.locationPink,
                    height: 11.68,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    shopOwner.address1 ?? 'not_available'.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
