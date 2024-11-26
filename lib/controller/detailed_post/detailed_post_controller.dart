import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/app_consts.dart';
import '../../model/detailed_post/detailed_post_res_model.dart';
import '../../model/news_feed/posts_res_model.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';
import '../news_feed/news_feed_controller.dart';

class DetailedPostController extends GetxController {
  final newsFeedController = Get.find<NewsFeedController>();
  late TextEditingController commentController;
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxBool isCreatingComment = false.obs;


  int? mPostId;
  DetailedPost? mPostData;
  RxString mPostOwnerName = ''.obs;
  RxString mPostOwnerProfileImage = ''.obs;
  RxString mPostOwnerUsername = ''.obs;
  RxString mPostTimeAgo = ''.obs;
  RxString mPostText = ''.obs;
  RxBool mIsPostLike = false.obs;
  RxInt mPostLikesCount = 0.obs;
  RxInt mPostCommentsCount = 0.obs;
  RxList<Comment> mPostComments = <Comment>[].obs;
  RxList<Post> mPostMedia = <Post>[].obs;

  @override
  void onInit() {
    commentController = TextEditingController();
    setupArgumentsData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setupArgumentsData() {
    Helpers.printLog(screenName: "SetupArgs", message: "init");
    Map<String, dynamic> data = Get.arguments;
    if (data.containsKey(AppConsts.keyPostId)) {
      mPostId = data[AppConsts.keyPostId];
      debugPrint('POST_ID = $mPostData');
    }
    if (mPostId != null) {
      debugPrint('POST_ID = $mPostData');
      getPostDetails();
    }
  }

  void getPostDetails() async {
    isLoading.value = true;
    var response = await GetRequests.getPostDetails(mPostId!);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        mPostData = response.data!;
        setUpPostDetailData();
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void setUpPostDetailData() {
    if (mPostData != null) {
      mIsPostLike.value = mPostData!.isLike == 1;
      mPostComments.value = mPostData!.comments ?? <Comment>[];
      if (mPostData!.post != null) {
        // mPostTimeAgo.value = Helpers.calculateTimeAgo(mPostData!.post!.createdAt);
        mPostText.value = mPostData!.post!.thought ?? '';
        mPostLikesCount.value = mPostData!.post!.totalLikes ?? 0;
        mPostCommentsCount.value = mPostData!.post!.totalComments ?? 0;
        mPostMedia.value = mPostData!.post!.posts ?? <Post>[];
        if (mPostData!.post!.user != null) {
          mPostOwnerName.value = mPostData!.post!.user!.name ?? '';
          mPostOwnerProfileImage.value = mPostData!.post!.user!.avatar ?? '';
          mPostOwnerUsername.value = mPostData!.post!.user!.userName ?? '';
        }
      }
    }
  }

  void toggleFavoriteStatus() async {
    Map<String, dynamic> requestBody = {
      'post_id': mPostId.toString(),
    };
    var response = await PostRequests.toggleFavoriteStatus(requestBody);
    if (response != null) {
      if (response.success) {
        mIsPostLike.value = response.status == 1 ? true : false;
        if (response.status == 1) {
          mPostLikesCount.value += 1;
        } else {
          mPostLikesCount.value -= 1;
        }
        toggleFavoriteStatusAtNewsFeed(response.status ?? 0);
      } else {}
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void toggleFavoriteStatusAtNewsFeed(int favoriteStatus) {
    if (newsFeedController.posts.any((post) => post.id == mPostId)) {
      newsFeedController.posts.firstWhere((post) => post.id == mPostId).isLike =
          favoriteStatus;

      if (favoriteStatus == 1) {
        newsFeedController.posts
            .firstWhere((post) => post.id == mPostId)
            .totalLikes = newsFeedController.posts
                .firstWhere((post) => post.id == mPostId)
                .totalLikes! +
            1;
      } else {
        newsFeedController.posts
            .firstWhere((post) => post.id == mPostId)
            .totalLikes = newsFeedController.posts
                .firstWhere((post) => post.id == mPostId)
                .totalLikes! -
            1;
      }
      newsFeedController.posts.refresh();
    }
  }

  void createComment() async {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar('error'.tr, 'message_empty_comment'.tr);
    } else {
      if (mPostId != null) {
        FocusManager.instance.primaryFocus?.unfocus();
        String comment = commentController.text.trim();
        Map<String, dynamic> requestBody = {
          'post_id': mPostId,
          'comment': comment,
        };

        isCreatingComment.value = true;
        commentController.clear();
        var response = await PostRequests.createComment(requestBody);
        isCreatingComment.value = false;
        if (response != null) {
          if (response.success) {
            if (response.data != null) {
              mPostCommentsCount.value++;
              mPostComments.insert(0, response.data!);
              increaseCommentCountAtNewsFeed();
              Future.delayed(const Duration(milliseconds: 500), () {
                scrollController
                    .jumpTo(scrollController.position.minScrollExtent);
              });
            }
          } else {
            Get.snackbar('error'.tr, response.message);
            commentController.text = comment;
          }
        } else {
          Get.snackbar('error'.tr, 'message_server_error'.tr);
          commentController.text = comment;
        }
      }
    }
  }

  void increaseCommentCountAtNewsFeed() {
    if (newsFeedController.posts.any((post) => post.id == mPostId)) {
      if (newsFeedController.posts
              .firstWhere((post) => post.id == mPostId)
              .totalComments !=
          null) {
        newsFeedController.posts
            .firstWhere((post) => post.id == mPostId)
            .totalComments = newsFeedController.posts
                .firstWhere((post) => post.id == mPostId)
                .totalComments! +
            1;
        newsFeedController.posts.refresh();
      }
    }
  }

  void toggleCommentFavoriteStatusRemote(int index) async {
    Map<String, dynamic> requestBody = {
      'comment_id': mPostComments[index].id,
    };
    var response = await PostRequests.toggleCommentFavoriteStatus(requestBody);
    if (response != null) {
      if (response.success) {
        toggleCommentFavoriteStatus(index);
      } else {}
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void toggleCommentFavoriteStatus(int index) {
    if (mPostComments[index].isLike == 0) {
      mPostComments[index].isLike = 1;
      mPostComments[index].countLikes = mPostComments[index].countLikes! + 1;
    } else {
      mPostComments[index].isLike = 0;
      mPostComments[index].countLikes = mPostComments[index].countLikes! - 1;
    }
    mPostComments.refresh();
  }
}
