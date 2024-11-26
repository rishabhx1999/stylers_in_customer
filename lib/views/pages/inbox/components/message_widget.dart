import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

class MessageWidget extends StatelessWidget {
  bool isCustomer;

  MessageWidget({Key? key, required this.isCustomer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCustomer
        ? Row(
            children: [
              const SizedBox(
                width: 59.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 9.0),
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontSize: AppConsts.commonFontSizeFactor * 12),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            '12:23',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 5.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(AppImages.img_stylists_dummy),
                    radius: 22.0,
                  ),
                ],
              ),
              const SizedBox(
                width: 3.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 9.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.black,
                            fontSize: AppConsts.commonFontSizeFactor * 12),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            '12:23',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
