import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/views/widgets/common/common_app_bar.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_icons.dart';
import '../../../controller/detailed_post/photo_controller.dart';

class PhotoScreen extends StatelessWidget {
  final _photoController = Get.put(PhotoController());

  PhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Stack(
          children: [
            Obx(
              () => Image.network(
                _photoController.photo.value,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: 24.0,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
