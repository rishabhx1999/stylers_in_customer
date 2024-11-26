// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stylers_in_customer/config/app_colors.dart';
// import 'package:stylers_in_customer/consts/app_consts.dart';
//
// class SearchCategoriesBar extends StatelessWidget {
//   List<String> categoryList;
//   RxInt selectedCategoryIndex;
//   Function(int newCategoryIndex) onTapCategory;
//
//   SearchCategoriesBar(
//       {Key? key,
//       required this.categoryList,
//       required this.selectedCategoryIndex,
//       required this.onTapCategory})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       for (var category in categoryList)
//         buildCategory(category, categoryList.indexOf(category), context)
//       // buildCategory(categoryList[0], 0, context),
//       // buildCategory(categoryList[1], 1, context),
//       // buildCategory(categoryList[2], 2, context),
//       // buildCategory(categoryList[3], 3, context),
//     ]);
//   }
//
//   Widget buildCategory(String category, int index, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTapCategory(index);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(right: 2.0),
//         child: Obx(
//           () => Container(
//             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 11.0),
//             decoration: BoxDecoration(
//                 color: index == selectedCategoryIndex.value
//                     ? AppColors.kPrimaryColor
//                     : AppColors.kPrimaryColor.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(11.0)),
//             child: Text(
//               category,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: index == selectedCategoryIndex.value
//                       ? Colors.white
//                       : Colors.black,
//                   fontSize: AppConsts.commonFontSizeFactor * 12.0,
//                   fontWeight: FontWeight.w300),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class ChipWidget extends StatelessWidget {
  String title;
  int currentIndex;
  RxInt selectedIndex;
  Function(int index) onTap;

  ChipWidget(
      {Key? key,
      required this.title,
      required this.currentIndex,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(currentIndex);
      },
      child: Obx(
        () => AnimatedContainer(
          padding:
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
          decoration: BoxDecoration(
              color: currentIndex == selectedIndex.value
                  ? AppColors.kPrimaryColor
                  : AppColors.kPrimaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(13.0)),
          duration: Duration(milliseconds: 200),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: currentIndex == selectedIndex.value
                    ? Colors.white
                    : Colors.black,
                fontSize: AppConsts.commonFontSizeFactor * 12.0))
        ),
      ),
    );
  }
}
