import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';

class CommonDropdownWidget extends StatelessWidget {
  Widget? dropdownIcon;
  var value;
  Function onChanged;
  var items;

  CommonDropdownWidget(
      {Key? key,
      this.dropdownIcon,
      required this.value,
      required this.onChanged,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 13.0, right: 18.75),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.28))),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton2(
            icon: dropdownIcon ?? const Icon(Icons.arrow_drop_down),
            value: value.value,
            onChanged: (value) {
              onChanged(value);
            },
            items: items,
          ),
        ),
      ),
    );
  }
}
