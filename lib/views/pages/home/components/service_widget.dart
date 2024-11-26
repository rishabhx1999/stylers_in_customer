import 'package:flutter/material.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';

class ServiceWidget extends StatelessWidget {
  ServiceWidget({Key? key, required this.service, required this.onTap})
      : super(key: key);
  Service service;
  Function(Service service) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(service);
      },
      child: Container(
        width: 98,
        height: 87,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   icon,
              //   width: 28,
              // ),

              service.image !=null?

              Image.network(
                service.image!,
                height: 32.0,
              ) :  Image.asset(
                AppImages.imgPlaceholder,
                height: 32.0,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                service.name??'',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
