import 'package:flutter/material.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5.84,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(23.0, 13.0, 20.0, 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(AppImages.img_stylists_dummy),
              radius: 17.5,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 3.0,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'You have a',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12,
                                      color: AppColors.color_29)),
                          TextSpan(
                            text: ' Haircut',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.color_29),
                          ),
                          TextSpan(
                            text: ' appointment today (24-03-2022) with',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12,
                                    color: AppColors.color_29),
                          ),
                          TextSpan(
                            text: ' Adam Sandler.',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.color_29),
                          ),
                        ])),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('18m',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 8,
                                  color: AppColors.color_29.withOpacity(0.6),fontWeight: FontWeight.w300,))
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
