import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_formatters.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/payments/payment_controller.dart';
import 'package:stylers_in_customer/utils/validations.dart';

import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';

class PaymentScreen extends StatelessWidget {
  final _paymentController = Get.put(PaymentController());

  PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'payment_methods'.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 33.0,
              ),
              Text(
                'choose_a_payment_method'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 18,),
              ),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    width: 84.0,
                    height: 74.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                            width: 0.5,
                            color: AppColors.kPrimaryColor.withOpacity(0.28))),
                    child: SvgPicture.asset(AppIcons.ic_wallet),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    width: 84.0,
                    height: 74.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                            width: 0.5,
                            color: AppColors.kPrimaryColor.withOpacity(0.28))),
                    child: SvgPicture.asset(AppIcons.ic_visa),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    width: 84.0,
                    height: 74.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                            width: 0.5,
                            color: AppColors.kPrimaryColor.withOpacity(0.28))),
                    child: SvgPicture.asset(AppIcons.ic_paypal),
                  )
                ],
              ),
              const SizedBox(
                height: 64.0,
              ),
              Text(
                'card_details'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 18,),
              ),
              const SizedBox(
                height: 13.0,
              ),
              Text(
                'card_number'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
              ),
              const SizedBox(
                height: 9.0,
              ),
              CommonInputField(
                marginTop: 0,
                marginLeft: 0,
                marginBottom: 0,
                marginRight: 0,
                controller: _paymentController.cardNoController,
                hint: 'xxxx xxxx xxxx',
                validator: Validations.checkCardNoValidations,
                inputType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'name'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
              ),
              const SizedBox(
                height: 9.0,
              ),
              CommonInputField(
                marginTop: 0,
                marginLeft: 0,
                marginBottom: 0,
                marginRight: 0,
                controller: _paymentController.nameController,
                hint: 'xxxx xxxx xxxx',
                validator: Validations.checkFullNameValidations,
                inputType: TextInputType.name,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'expiry_date'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                      ),
                      const SizedBox(
                        height: 9.0,
                      ),
                      CommonInputField(
                        marginTop: 0,
                        marginLeft: 0,
                        marginBottom: 0,
                        marginRight: 0,
                        onChanged: (value) {
                          if (value.length > 5) {
                            _paymentController.expiryController.text =
                                value.substring(0, 5);
                          }
                          _paymentController.expiryController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _paymentController
                                      .expiryController.text.length));
                        },
                        controller: _paymentController.expiryController,
                        hint: '03/25',
                        validator: Validations.checkCardExpiryValidations,
                        inputType: TextInputType.datetime,
                        inputFormatter: [CardExpirationFormatter()],
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 19.0,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'cvc_number'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                      ),
                      const SizedBox(
                        height: 9.0,
                      ),
                      CommonInputField(
                        marginTop: 0,
                        marginLeft: 0,
                        marginBottom: 0,
                        marginRight: 0,
                        onChanged: (value) {
                          if (value.length > 3) {
                            _paymentController.cvcController.text =
                                value.substring(0, 3);
                          }
                          _paymentController.cvcController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _paymentController
                                      .cvcController.text.length));
                        },
                        controller: _paymentController.cvcController,
                        hint: 'xxx',
                        validator: Validations.checkCardCVCValidations,
                        inputType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 76.0,
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 25.0),
        child: CommonButton(
          text: 'proceed'.tr,
          borderRadius: 2.0,
          onClick: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.toNamed(AppRoutes.routePaymentConfirmation);
          },
          horizontalMargin: 0,
        ),
      ),
    );
  }
}
