import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/messages/messages_controller.dart';
import '../../widgets/common/common_button.dart';
import 'components/message_widget.dart';
import 'package:stylers_in_customer/config/app_colors.dart';

class MessagesScreen extends StatelessWidget {
  final _messageController = Get.put(MessagesController());

  MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Colors.black.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(17.5),
    );
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  width: 23.87,
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: SvgPicture.asset(AppIcons.ic_back)),
                const SizedBox(
                  width: 21.5,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage(AppImages.img_stylists_dummy),
                  radius: 16.5,
                ),
                const SizedBox(
                  width: 11.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lara Seth',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 16),
                    ),
                    Text(
                      'Hair Stylist',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: AppConsts.commonFontSizeFactor * 12),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                    width: 119.0,
                    height: 38.0,
                    child: CommonButton(
                      text: 'book_now',
                      onClick: () {
                        Get.toNamed(AppRoutes.routeCreateAppointment);
                      },
                      borderRadius: 6.0,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 51.0,
                ),
                ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessageWidget(
                        isCustomer: index % 2 == 0 ? true : false,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: 15),
                const SizedBox(
                  height: 9.0,
                )
              ],
            ),
          ),
          Column(
            children: [const Spacer(),
              AspectRatio(
                aspectRatio: 4.87,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20.5, 7.0, 20.0, 35.0),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _messageController.messageController,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.kPrimaryDarkColor,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Container(
                                  width: 29.0,
                                  height: 29.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.kPrimaryColor
                                              .withOpacity(0.24),
                                          width: 1.0)),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.ic_message_send,
                                      height: 14.0,
                                    ),
                                  ),
                                )),
                            hintText: 'type_your_message'.tr,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: AppConsts.commonFontSizeFactor * 12,
                                    color: Colors.black.withOpacity(0.4),fontWeight: FontWeight.w300,),
                            fillColor: AppColors.kPrimaryColor.withOpacity(0.02),
                            filled: true,
                            errorBorder: messageFieldBorder,
                            enabledBorder: messageFieldBorder,
                            disabledBorder: messageFieldBorder,
                            focusedBorder: messageFieldBorder,
                            focusedErrorBorder: messageFieldBorder,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kPrimaryColor),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
