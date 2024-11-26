import 'package:get/get.dart';

class ReviewsController extends GetxController {
  var mStylistRating = 2.0.obs;

  List<String> chipOptions = ['All', 'Positive', 'Critical'];
  var selectedChipIndex = 0.obs;

  onChipTap(int newIndex) {
    selectedChipIndex.value = newIndex;
  }
}
