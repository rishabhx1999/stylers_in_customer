import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

import '../../../../consts/app_images.dart';

class InboxCellWidget extends StatelessWidget {
  bool isRead;
  Function onTap;

  InboxCellWidget({Key? key, required this.isRead, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(14.0, 9.0, 20.0, 12.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: isRead ? Colors.white : AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(AppImages.img_stylists_dummy),
                  radius: 22,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        'Ivan Smith',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: isRead ? Colors.black : Colors.white,
                            ),
                      ),
                      Text(
                        'Hair Stylist',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: isRead
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                            fontSize: AppConsts.commonFontSizeFactor * 12),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      '2D',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: isRead
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                          fontSize: AppConsts.commonFontSizeFactor * 12),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur ',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: isRead ? Colors.black : Colors.white,
                  fontSize: AppConsts.commonFontSizeFactor * 12),
            )
          ],
        ),
      ),
    );
  }
}
