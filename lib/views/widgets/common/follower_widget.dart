import 'package:flutter/material.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/views/widgets/common/common_button_outline.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../model/followers_list/followers_list_res_model.dart';

class FollowerWidget extends StatelessWidget {
  FollowerWidget({Key? key, required this.followerData}) : super(key: key);

  Follower followerData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage(AppImages.imgUserPlaceholder),
              foregroundImage: NetworkImage(followerData.user!.avatar!),
              radius: 20.5,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followerData.user == null
                          ? ''
                          : followerData.user!.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 12),
                    ),
                    Text(
                      followerData.user == null
                          ? ''
                          : '@${followerData.user!.userName}' ?? '',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black.withOpacity(0.50),
                          fontSize: AppConsts.commonFontSizeFactor * 12),
                    ),
                  ]),
            ),
            // CommonButtonOutline(
            //   backgroundColor: AppColors.appBackgroundColor,
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
