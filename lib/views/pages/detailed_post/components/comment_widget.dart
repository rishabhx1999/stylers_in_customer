import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../consts/app_consts.dart';
import '../../../../consts/app_icons.dart';
import '../../../../consts/app_images.dart';
import '../../../../model/detailed_post/detailed_post_res_model.dart';

class CommentWidget extends StatelessWidget {
  Comment commentData;
  Function toggleFavoriteStatus;
  int index;

  CommentWidget(
      {Key? key,
      required this.commentData,
      required this.toggleFavoriteStatus,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.5,
          backgroundImage: const AssetImage(AppImages.imgUserPlaceholder),
          foregroundImage: NetworkImage(commentData.user!.avatar!),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    commentData.user == null
                        ? ''
                        : commentData.user!.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black),
                  ),
                  // Text(
                  //   Helpers.calculateTimeAgo(commentData.createdAt),
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: Theme.of(context).textTheme.headline5?.copyWith(
                  //       fontSize: AppConsts.commonFontSizeFactor * 12,
                  //       overflow: TextOverflow.ellipsis,
                  //       color: Colors.black.withOpacity(0.5)),
                  // ),
                ],
              ),
              Text(
                commentData.user == null
                    ? ''
                    : '@${commentData.user!.userName}' ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    color: Colors.black.withOpacity(0.5)),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                commentData.comment.toString(),
                softWrap: true,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 6.0,
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    toggleFavoriteStatus(index);
                  },
                  icon: commentData.isLike == 1
                      ? SvgPicture.asset(
                          AppIcons.ic_heart_filled,
                          height: 15.0,
                          color: AppColors.kPrimaryColor,
                        )
                      : SvgPicture.asset(
                          AppIcons.ic_heart,
                          height: 15.0,
                          color: Colors.black,
                        ),
                  label: Text(
                    commentData.countLikes.toString(),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        color: Colors.black.withOpacity(0.5)),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
