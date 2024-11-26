import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import '../../../config/app_colors.dart';
import '../../../model/news_feed/posts_res_model.dart';
import '../../../utils/preference_manager.dart';
import '../../dialogs/common/common_dialog.dart';
import 'collage_widget.dart';

class CommonNewsFeedWidget extends StatelessWidget {
  CommonNewsFeedWidget(
      {Key? key,
      required this.postData,
      required this.toggleFavoriteStatus,
      required this.isLoggedIn})
      : super(key: key);

  PostData postData;
  Function toggleFavoriteStatus;
  bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (isLoggedIn) {
                  Get.toNamed(AppRoutes.routeProfileDetailScreen, arguments: {
                    AppConsts.keyProviderId: postData.userId,
                  });
                } else {
                  CommonDialog.show(
                      context: context,
                      middleText: 'login_required_message'.tr,
                      onCancelPress: () {
                        Get.offAllNamed(AppRoutes.routeLogin);
                        PreferenceManager.save2Pref(
                            PreferenceManager.prefIsVisitor, false);
                      });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage(AppImages.imgUserPlaceholder),
                    foregroundImage: NetworkImage(postData.user!.avatar!),
                    radius: 20.5,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (isLoggedIn) {
                        Get.toNamed(AppRoutes.routeProfileDetailScreen,
                            arguments: {
                              AppConsts.keyProviderId: postData.userId,
                            });
                      } else {
                        CommonDialog.show(
                            context: context,
                            middleText: 'login_required_message'.tr,
                            onCancelPress: () {
                              Get.offAllNamed(AppRoutes.routeLogin);
                              PreferenceManager.save2Pref(
                                  PreferenceManager.prefIsVisitor, false);
                            });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          postData.user!.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                        ),
                        Text(
                          '@${postData.user!.userName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (isLoggedIn) {
                        Get.toNamed(AppRoutes.routeDetailedPost,
                            arguments: {AppConsts.keyPostId: postData.id});
                      } else {
                        CommonDialog.show(
                            context: context,
                            middleText: 'login_required_message'.tr,
                            onCancelPress: () {
                              Get.offAllNamed(AppRoutes.routeLogin);
                              PreferenceManager.save2Pref(
                                  PreferenceManager.prefIsVisitor, false);
                            });
                      }
                    },
                    child: Text(
                      postData.thought ?? '',
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (postData.posts != null && postData.posts!.isNotEmpty)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (isLoggedIn) {
                          Get.toNamed(AppRoutes.routeDetailedPost,
                              arguments: {AppConsts.keyPostId: postData.id});
                        } else {
                          CommonDialog.show(
                              context: context,
                              middleText: 'login_required_message'.tr,
                              onCancelPress: () {
                                Get.offAllNamed(AppRoutes.routeLogin);
                                PreferenceManager.save2Pref(
                                    PreferenceManager.prefIsVisitor, false);
                              });
                        }
                      },
                      child: CollageWidget(
                        media: postData.posts!,
                        fromPostDetail: false,
                        postId: postData.id,
                      ),
                    ),
                  SizedBox(
                    height: 30.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            onPressed: () {
                              if (isLoggedIn) {
                                toggleFavoriteStatus(postData.id);
                              } else {
                                CommonDialog.show(
                                    context: context,
                                    middleText: 'login_required_message'.tr,
                                    onCancelPress: () {
                                      Get.offAllNamed(AppRoutes.routeLogin);
                                      PreferenceManager.save2Pref(
                                          PreferenceManager.prefIsVisitor,
                                          false);
                                    });
                              }
                            },
                            icon: Wrap(children: [
                              postData.isLike == 1
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
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                postData.totalLikes.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        color: Colors.black.withOpacity(0.5)),
                              )
                            ]),
                            label: const Text('')),
                        TextButton.icon(
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            onPressed: () {
                              if (isLoggedIn) {
                                Get.toNamed(AppRoutes.routeDetailedPost,
                                    arguments: {
                                      AppConsts.keyPostId: postData.id
                                    });
                              } else {
                                CommonDialog.show(
                                    context: context,
                                    middleText: 'login_required_message'.tr,
                                    onCancelPress: () {
                                      Get.offAllNamed(AppRoutes.routeLogin);
                                      PreferenceManager.save2Pref(
                                          PreferenceManager.prefIsVisitor,
                                          false);
                                    });
                              }
                            },
                            icon: Wrap(children: [
                              SvgPicture.asset(
                                AppIcons.ic_comment,
                                height: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                postData.totalComments.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        color: Colors.black.withOpacity(0.5)),
                              )
                            ]),
                            label: const Text('')),
                        IconButton(
                            onPressed: () {
                              if (isLoggedIn) {
                              } else {
                                CommonDialog.show(
                                    context: context,
                                    middleText: 'login_required_message'.tr,
                                    onCancelPress: () {
                                      Get.offAllNamed(AppRoutes.routeLogin);
                                      PreferenceManager.save2Pref(
                                          PreferenceManager.prefIsVisitor,
                                          false);
                                    });
                              }
                            },
                            icon: SvgPicture.asset(
                              AppIcons.ic_share,
                              height: 15.0,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
