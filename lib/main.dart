import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/config/app_theme.dart';
import 'package:stylers_in_customer/config/local_strings.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:stylers_in_customer/utils/my_http_override.dart';
import 'package:stylers_in_customer/views/pages/address/additional_address_detail_screen.dart';
import 'package:stylers_in_customer/views/pages/address/pick_address_map_screen.dart';
import 'package:stylers_in_customer/views/pages/address/search_address_screen.dart';
import 'package:stylers_in_customer/views/pages/appointment/appointment_detail_screen.dart';
import 'package:stylers_in_customer/views/pages/appointment/create_appointment_screen.dart';
import 'package:stylers_in_customer/views/pages/booking_history/booking_history_screen.dart';
import 'package:stylers_in_customer/views/pages/change_password/password_changed_screen.dart';
import 'package:stylers_in_customer/views/pages/customer_profile/customer_profile_screen.dart';
import 'package:stylers_in_customer/views/pages/customer_wallet/customer_wallet_screen.dart';
import 'package:stylers_in_customer/views/pages/detailed_post/photo_screen.dart';
import 'package:stylers_in_customer/views/pages/detailed_post/video_screen.dart';
import 'package:stylers_in_customer/views/pages/edit_profile/edit_profile_screen.dart';
import 'package:stylers_in_customer/views/pages/forgot_password/forgot_password_screen.dart';
import 'package:stylers_in_customer/views/pages/forgot_password/password_updated_screen.dart';
import 'package:stylers_in_customer/views/pages/forgot_password/set_new_password_screen.dart';
import 'package:stylers_in_customer/views/pages/forgot_password/verify_otp_forgot_password.dart';
import 'package:stylers_in_customer/views/pages/inbox/messages_screen.dart';
import 'package:stylers_in_customer/views/pages/news_feed/news_feed_screen.dart';
import 'package:stylers_in_customer/views/pages/payments/payment_screen.dart';
import 'package:stylers_in_customer/views/pages/payments/payment_confirmation_screen.dart';
import 'package:stylers_in_customer/views/pages/detailed_post/detailed_post_screen.dart';
import 'package:stylers_in_customer/views/pages/profile_detail/profile_detail_screen.dart';
import 'package:stylers_in_customer/views/pages/search/search_screen.dart';
import 'package:stylers_in_customer/views/pages/services/service_categories_screen.dart';
import 'package:stylers_in_customer/views/pages/settings/settings_screen.dart';
import 'package:stylers_in_customer/views/pages/shop/shops_screen.dart';
import 'package:stylers_in_customer/views/pages/signup/verification_success_screen.dart';
import 'package:stylers_in_customer/views/pages/signup/verify_otp_screen.dart';
import 'package:stylers_in_customer/utils/preference_manager.dart';
import 'package:stylers_in_customer/views/pages/dashboard/dashboard_screen.dart';
import 'package:stylers_in_customer/views/pages/login/login_screen.dart';
import 'package:stylers_in_customer/views/pages/on_boarding/on_boarding_screen.dart';
import 'package:stylers_in_customer/views/pages/search_location/search_location_screen.dart';
import 'package:stylers_in_customer/views/pages/signup/signup_screen.dart';
import 'package:stylers_in_customer/views/pages/splash/splash_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:stylers_in_customer/views/pages/followers/followers_screen.dart';
import 'package:stylers_in_customer/views/pages/stylists/stylists_screen.dart';
import 'package:stylers_in_customer/views/pages/appointment/refund_confirmation_screen.dart';
import 'package:stylers_in_customer/views/pages/change_password/change_password_screen.dart';
import 'package:stylers_in_customer/views/pages/reviews/reviews_screen.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  await PreferenceManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final int transitionDuration = 300;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            translations: LocalStrings(),
            locale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            title: AppConsts.appName,
            theme: appTheme(context),
            home: const SplashScreen(),
            getPages: [
              GetPage(
                  name: AppRoutes.routeSplash,
                  page: () => const SplashScreen()),
              GetPage(
                  name: AppRoutes.routeOnBoardingPage,
                  page: () => const OnBoardingScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeLogin,
                  page: () => LoginScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSignup,
                  page: () => SignupScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeVerifyOtp,
                  page: () => VerifyOtpScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSearchLocation,
                  page: () => SearchLocationScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeVerificationSuccess,
                  page: () => VerificationSuccessScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeForgotPassword,
                  page: () => ForgotPasswordScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeVerifyOtpForgotPassword,
                  page: () => VerifyOtpForgotPassword(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSetNewPassword,
                  page: () => SetNewPasswordScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePasswordUpdated,
                  page: () => PasswordUpdatedScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeDashboard,
                  page: () => DashboardScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeServiceCategories,
                  page: () => ServiceCategoriesScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSearchScreen,
                  page: () => SearchScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeStylistsList,
                  page: () => StylistsScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeShopsList,
                  page: () => ShopsScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeShopsList,
                  page: () => NewsFeedScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeCreateAppointment,
                  page: () => SendAppointmentScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeAppointmentDetail,
                  page: () => AppointmentDetailScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeProfileDetailScreen,
                  page: () => ProfileDetailScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeFollowers,
                  page: () => FollowersScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeCustomerProfile,
                  page: () => CustomerProfileScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePayment,
                  page: () => PaymentScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePaymentConfirmation,
                  page: () => const PaymentConfirmationScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeDetailedPost,
                  page: () => PostScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeCustomerWallet,
                  page: () => const CustomerWalletScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeEditProfile,
                  page: () => EditProfileScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeRefundConfirmation,
                  page: () => RefundConfirmationScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSettings,
                  page: () => SettingsScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeChangePassword,
                  page: () => ChangePasswordScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePasswordChanged,
                  page: () => const PasswordChangedScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeReviews,
                  page: () => ReviewsScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeBookingHistory,
                  page: () => const BookingHistoryScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeMessages,
                  page: () => MessagesScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePhotoScreen,
                  page: () => PhotoScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeVideoScreen,
                  page: () => VideoScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeSearchAddressScreen,
                  page: () => SearchAddressScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routeAdditionalAddressDetailScreen,
                  page: () => AdditionalAddressDetailScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
              GetPage(
                  name: AppRoutes.routePickAddressMapScreen,
                  page: () => PickAddressMapScreen(),
                  transition: Transition.rightToLeft,
                  transitionDuration:
                      Duration(milliseconds: transitionDuration)),
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              Locale('es'),
              Locale('de'),
              Locale('fr'),
              Locale('el'),
              Locale('et'),
              Locale('nb'),
              Locale('nn'),
              Locale('pl'),
              Locale('pt'),
              Locale('ru'),
              Locale('hi'),
              Locale('ne'),
              Locale('uk'),
              Locale('hr'),
              Locale('tr'),
              Locale('lv'),
              Locale('lt'),
              Locale('ku'),
              Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
              // Generic Simplified Chinese 'zh_Hans'
              Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
              // Generic traditional Chinese 'zh_Hant'
            ],
            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
          );
        });
      },
    );
  }
}
