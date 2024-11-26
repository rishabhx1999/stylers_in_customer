import 'package:get/get.dart';

import '../../model/news_feed/posts_res_model.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../utils/preference_manager.dart';

class NewsFeedController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString personImage = "".obs;

  var posts = <PostData>[].obs;

  @override
  void onInit() {
    getUserDataFromPref();
    super.onInit();
  }

  getUserDataFromPref() {
    if (PreferenceManager.getPref(PreferenceManager.prefIsLogin) != null) {
      isLoggedIn.value =
          (PreferenceManager.getPref(PreferenceManager.prefIsLogin) as bool?)!;
    }

    if (PreferenceManager.getPref(PreferenceManager.prefUserImage) != null) {
      personImage.value =
          (PreferenceManager.getPref(PreferenceManager.prefUserImage)
              as String?)!;
    }
    getPosts();
  }

  void getPosts() async {
    var response;
    isLoading.value = true;
    if (isLoggedIn.value) {
      response = await GetRequests.getPosts();
    } else {
      response = await GetRequests.getGuestPosts();
    }
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        posts.clear();
        posts.value = response.data!;
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void toggleFavoriteStatusRemote(int postId) async {
    toggleFavoriteStatus(postId);
    Map<String, dynamic> requestBody = {
      'post_id': postId.toString(),
    };
    var response = await PostRequests.toggleFavoriteStatus(requestBody);
    if (response != null) {
      if (response.success) {
      } else {
        toggleFavoriteStatus(postId);
      }
    } else {
      toggleFavoriteStatus(postId);
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void toggleFavoriteStatus(int postId) {
    if (posts.any((post) => post.id == postId)) {
      var post = posts.firstWhere((post) => post.id == postId);
      var index = posts.indexOf(post);

      if (posts[index].totalLikes != null) {
        if (posts[index].isLike == 0) {
          posts[index].isLike = 1;
          posts[index].totalLikes = posts[index].totalLikes! + 1;
        } else {
          posts[index].isLike = 0;
          posts[index].totalLikes = posts[index].totalLikes! - 1;
        }
        posts.refresh();
      }
    }
  }

// void toggleFavoriteStatus(int postId) {
//   if (posts.any((post) => post.id == postId)) {
//     posts.firstWhere((post) => post.id == postId).isLike = response.status;
//
//     if (response.status == 1) {
//       posts.firstWhere((post) => post.id == postId).totalLikes =
//           posts.firstWhere((post) => post.id == postId).totalLikes! + 1;
//     } else {
//       posts.firstWhere((post) => post.id == postId).totalLikes =
//           posts.firstWhere((post) => post.id == postId).totalLikes! - 1;
//     }
//     posts.refresh();
//   }
// }
}
