import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class CommonServiceWidget extends StatelessWidget {
  CommonServiceWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onServiceTap})
      : super(key: key);
  String icon;
  String title;
  Function() onServiceTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onServiceTap();
      },
      child: Container(
        width: 98,
        height: 87,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Image.network(
              icon,
              height: 38.0,
            ),
            // SvgPicture.asset(
            //   icon,
            //   height: 38,
            // ),
            const SizedBox(
              height: 11.33,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 13,
                  fontWeight: FontWeight.w400),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
