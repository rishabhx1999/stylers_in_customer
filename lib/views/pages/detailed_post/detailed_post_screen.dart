import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';
import '../../../consts/app_images.dart';
import '../../../controller/detailed_post/detailed_post_controller.dart';
import '../../widgets/common/collage_widget.dart';
import '../../widgets/common/common_app_bar.dart';
import 'components/comment_widget.dart';

class PostScreen extends StatelessWidget {
  final _detailedPostController = Get.put(DetailedPostController());

  PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var commentFieldBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.09)));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CommonAppBar(
        title: 'post'.tr,
        onBackTap: () {
          Get.back();
        },
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Obx(
          () => _detailedPostController.isLoading.value
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                        controller: _detailedPostController.scrollController,
                        child: /*Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor:
                                          AppColors.shimmerHighlightColor,
                                      child: Container(
                                        height: 41.0,
                                        width: 41.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.shimmerBaseColor,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Shimmer.fromColors(
                                                baseColor:
                                                    AppColors.shimmerBaseColor,
                                                highlightColor: AppColors
                                                    .shimmerHighlightColor,
                                                child: Container(
                                                  height: 12.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                    color: AppColors
                                                        .shimmerBaseColor,
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 2.0,
                                            ),
                                            Shimmer.fromColors(
                                                baseColor:
                                                    AppColors.shimmerBaseColor,
                                                highlightColor: AppColors
                                                    .shimmerHighlightColor,
                                                child: Container(
                                                  height: 12.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                    color: AppColors
                                                        .shimmerBaseColor,
                                                  ),
                                                )),
                                          ]),
                                    ],
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: Container(
                                height: 14.0,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              )),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: Container(
                                height: 14.0,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              )),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: Container(
                                height: 14.0,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              )),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: Container(
                                height: 14.0,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              )),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: Container(
                                height: 180.0,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              )),
                          const SizedBox(
                            height: 32.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40, right: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                    baseColor: AppColors.shimmerBaseColor,
                                    highlightColor:
                                        AppColors.shimmerHighlightColor,
                                    child: Container(
                                      height: 12.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.shimmerBaseColor,
                                      ),
                                    )),
                                Shimmer.fromColors(
                                    baseColor: AppColors.shimmerBaseColor,
                                    highlightColor:
                                        AppColors.shimmerHighlightColor,
                                    child: Container(
                                      height: 12.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.shimmerBaseColor,
                                      ),
                                    )),
                                Shimmer.fromColors(
                                    baseColor: AppColors.shimmerBaseColor,
                                    highlightColor:
                                        AppColors.shimmerHighlightColor,
                                    child: Container(
                                      height: 12.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.shimmerBaseColor,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 17.0,
                            endIndent: 16.0,
                            thickness: 1.0,
                            color: Colors.black.withOpacity(0.1),
                            height: 32.0,
                          ),
                          ListView.separated(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor: AppColors.shimmerBaseColor,
                                      highlightColor:
                                          AppColors.shimmerHighlightColor,
                                      child: Container(
                                        height: 41.0,
                                        width: 41.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.shimmerBaseColor,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      Shimmer.fromColors(
                                          baseColor: AppColors.shimmerBaseColor,
                                          highlightColor:
                                              AppColors.shimmerHighlightColor,
                                          child: Container(
                                            height: 12.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Shimmer.fromColors(
                                          baseColor: AppColors.shimmerBaseColor,
                                          highlightColor:
                                              AppColors.shimmerHighlightColor,
                                          child: Container(
                                            height: 12.0,
                                            width: 80.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Shimmer.fromColors(
                                          baseColor: AppColors.shimmerBaseColor,
                                          highlightColor:
                                              AppColors.shimmerHighlightColor,
                                          child: Container(
                                            height: 14.0,
                                            width: 240.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Shimmer.fromColors(
                                          baseColor: AppColors.shimmerBaseColor,
                                          highlightColor:
                                              AppColors.shimmerHighlightColor,
                                          child: Container(
                                            height: 14.0,
                                            width: 240.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Shimmer.fromColors(
                                          baseColor: AppColors.shimmerBaseColor,
                                          highlightColor:
                                              AppColors.shimmerHighlightColor,
                                          child: Container(
                                            height: 12.0,
                                            width: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 14.0,
                              );
                            },
                            itemCount: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                        ])*/
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => CircleAvatar(
                                          backgroundImage: const AssetImage(
                                              AppImages.imgUserPlaceholder),
                                          foregroundImage: NetworkImage(
                                              _detailedPostController
                                                  .mPostOwnerProfileImage
                                                  .value),
                                          radius: 20.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(
                                                    () => Text(
                                                      _detailedPostController
                                                          .mPostOwnerName.value,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          ?.copyWith(
                                                              fontSize: AppConsts
                                                                      .commonFontSizeFactor *
                                                                  12,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      '@${_detailedPostController.mPostOwnerUsername.value}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          ?.copyWith(
                                                              fontSize: AppConsts
                                                                      .commonFontSizeFactor *
                                                                  12,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5)),
                                                    ),
                                                  ),
                                                ]),
                                            Text(
                                              _detailedPostController
                                                  .mPostTimeAgo.value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  ?.copyWith(
                                                      fontSize: AppConsts
                                                              .commonFontSizeFactor *
                                                          12,
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 9.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Obx(
                                  () => Text(
                                    _detailedPostController.mPostText.value,
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: _detailedPostController
                                      .mPostMedia.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: CollageWidget(
                                      media: _detailedPostController.mPostMedia,
                                      fromPostDetail: true,
                                      postId:
                                          _detailedPostController.mPostId ?? 0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => TextButton.icon(
                                          style: TextButton.styleFrom(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () {
                                            _detailedPostController
                                                .toggleFavoriteStatus();
                                          },
                                          icon: _detailedPostController
                                                  .mIsPostLike.value
                                              ? SvgPicture.asset(
                                                  AppIcons.ic_heart_filled,
                                                  height: 15.0,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                )
                                              : SvgPicture.asset(
                                                  AppIcons.ic_heart,
                                                  height: 15.0,
                                                  color: Colors.black,
                                                ),
                                          label: Text(
                                            _detailedPostController
                                                .mPostLikesCount.value
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    fontSize: AppConsts
                                                            .commonFontSizeFactor *
                                                        12,
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                          )),
                                    ),
                                    Obx(
                                      () => TextButton.icon(
                                          style: TextButton.styleFrom(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                            AppIcons.ic_comment,
                                            height: 15.0,
                                          ),
                                          label: Text(
                                            _detailedPostController
                                                .mPostCommentsCount.value
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    fontSize: AppConsts
                                                            .commonFontSizeFactor *
                                                        12,
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: SvgPicture.asset(
                                          AppIcons.ic_share,
                                          height: 15.0,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 17.0,
                                endIndent: 16.0,
                                thickness: 1.0,
                                color: Colors.black.withOpacity(0.1),
                                height: 32.0,
                              ),
                              Obx(
                                () => _detailedPostController
                                        .mPostComments.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 64.0,
                                            ),
                                            Text(
                                              'no_comments'.tr,
                                              softWrap: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  ?.copyWith(
                                                      fontSize: AppConsts
                                                              .commonFontSizeFactor *
                                                          12,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        itemBuilder: (context, index) {
                                          return CommentWidget(
                                            commentData: _detailedPostController
                                                .mPostComments[index],
                                            toggleFavoriteStatus:
                                                _detailedPostController
                                                    .toggleCommentFavoriteStatusRemote,
                                            index: index,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 14.0,
                                          );
                                        },
                                        itemCount: _detailedPostController
                                            .mPostComments.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                              ),
                              const SizedBox(
                                height: 80.0,
                              ),
                            ])),
                    Column(
                      children: [
                        const Spacer(),
                        AspectRatio(
                          aspectRatio: 5.6,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 32.0, right: 14.0, bottom: 14.0),
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _detailedPostController
                                          .commentController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      cursorColor: AppColors.kPrimaryDarkColor,
                                      decoration: InputDecoration(
                                        hintText: 'type_your_comment'.tr,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                fontSize: AppConsts
                                                        .commonFontSizeFactor *
                                                    12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black
                                                    .withOpacity(0.4)),
                                        fillColor: AppColors.kPrimaryColor
                                            .withOpacity(0.02),
                                        filled: true,
                                        border: commentFieldBorder,
                                        errorBorder: commentFieldBorder,
                                        enabledBorder: commentFieldBorder,
                                        disabledBorder: commentFieldBorder,
                                        focusedBorder: commentFieldBorder,
                                        focusedErrorBorder: commentFieldBorder,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14.0,
                                  ),
                                  IconButton(
                                      iconSize: 36.0,
                                      onPressed: () {
                                        _detailedPostController.createComment();
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.color_F4_F7,
                                            border: Border.all(
                                                color: AppColors.kPrimaryColor
                                                    .withOpacity(0.24),
                                                width: 1.0)),
                                        child: Center(
                                          child: Icon(
                                            Icons.send,
                                            color: AppColors.color_1D,
                                            size: 18.0,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
