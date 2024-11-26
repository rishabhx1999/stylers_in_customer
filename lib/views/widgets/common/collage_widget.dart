import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_routes.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_images.dart';
import '../../../model/news_feed/posts_res_model.dart';

class CollageWidget extends StatelessWidget {
  List<Post> media;
  bool fromPostDetail;
  int postId;

  CollageWidget(
      {Key? key,
      required this.media,
      required this.fromPostDetail,
      required this.postId})
      : super(key: key);

  Widget buildCollageComponent(int mediaIndex) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: media[mediaIndex].media != null &&
                lookupMimeType(media[mediaIndex].media!) != null &&
                lookupMimeType(media[mediaIndex].media!)!.split('/').first ==
                    'video'
            ? GestureDetector(
                onTap: () {
                  if (fromPostDetail) {
                    Get.toNamed(AppRoutes.routeVideoScreen, arguments: {
                      AppConsts.keyMedia: media[mediaIndex].media!
                    });
                  } else {
                    Get.toNamed(AppRoutes.routeDetailedPost,
                        arguments: {AppConsts.keyPostId: postId});
                  }
                },
                child: Stack(
                  children: [
                    VideoPlayer(
                        VideoPlayerController.network(media[mediaIndex].media!)
                          ..initialize()),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          if (fromPostDetail) {
                            Get.toNamed(AppRoutes.routeVideoScreen, arguments: {
                              AppConsts.keyMedia: media[mediaIndex].media!
                            });
                          } else {
                            Get.toNamed(AppRoutes.routeDetailedPost,
                                arguments: {AppConsts.keyPostId: postId});
                          }
                        },
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ))
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  if (fromPostDetail) {
                    Get.toNamed(AppRoutes.routePhotoScreen, arguments: {
                      AppConsts.keyMedia: media[mediaIndex].media!
                    });
                  } else {
                    Get.toNamed(AppRoutes.routeDetailedPost,
                        arguments: {AppConsts.keyPostId: postId});
                  }
                },
                child: FadeInImage.assetNetwork(
                  placeholder: AppImages.imgPlaceholder,
                  image: media[mediaIndex].media!,
                  fit: BoxFit.cover,
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    for (var value in media) {
      if (value.media != null &&
          lookupMimeType(value.media!) != null &&
          lookupMimeType(value.media!)!.split('/').first == 'video') {
        VideoPlayerController.network(value.media!).dispose();
      }
    }
    return Container(
        alignment: Alignment.topCenter,
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            if (media.isNotEmpty)
              StaggeredGridTile.count(
                crossAxisCellCount: media.length > 1 ? 1 : 2,
                mainAxisCellCount: 1,
                child: buildCollageComponent(0),
              ),
            if (media.length > 1)
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: buildCollageComponent(1),
              ),
            if (media.length > 2)
              StaggeredGridTile.count(
                crossAxisCellCount: media.length > 3 ? 1 : 2,
                mainAxisCellCount: 1,
                child: buildCollageComponent(2),
              ),
            if (media.length > 3)
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: buildCollageComponent(3),
              ),
          ],
        ));
  }
}
