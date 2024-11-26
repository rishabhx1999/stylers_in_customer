import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //english
        'en_US': {
          //Common
          'internet_connection_message':
              'Could not fetch data. Make sure internet is connected',
          'message_filed_cannot_be_empty': 'Field can\'t be empty',

          //OnBoard
          'on_boarding_title_1': 'Book appointments anywhere, everywhere',
          'on_boarding_title_2':
              'More than 50,000 Stylists and Shops to choose from',
          'on_boarding_title_3': 'Start exploring now',
          'on_boarding_subtitle_1':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
          'on_boarding_subtitle_2':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
          'on_boarding_subtitle_3':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
          'next': 'Next',
          'sign_up': 'Sign Up',
          'already_have_account': 'Already have an account?',
          'sign_in': 'Sign In',
          'login_as_a_visitor': 'Login as a visitor',
          'welcome_back': 'Welcome Back!',
          'login_sub_title':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'enter_your_email': 'Enter your Email',
          'enter_your_password': 'Enter password',
          'remember_me': 'Remember me',
          'forgot_password_que': 'Forgot Password?',
          'or': 'Or',
          'dont_have_account': 'Don’t have an account?',
          'login': 'Login',

          'no_data_yet': 'No data yet',

          'alert': 'Alert',
          'take_a_photo': 'Take A Photo',
          'shoot_a_video': 'Shoot A Video',

          // email validation messages
          'message_enter_email': 'Please enter your email address',
          'message_invalid_email': 'Please enter a valid email address',
          //password validation messages
          'message_enter_password': 'Please enter your password',
          'message_enter_valid_password':
              'Password must contain at least one (uppercase, lowercase, digit, special character) and minimum 8 characters',
          'message_password_helper':
              'Password must contain atleast one (uppercase, lowercase, digit, special character) and minimum 8 characters',

          //signup screen

          'enter_your_details': 'Enter your details',
          'error': 'Error',
          'signup_subtitle':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'first_name': 'First Name',
          'last_name': 'Last Name',
          'username': 'Username',
          'your_phone_number': 'Your Phone Number',
          'enter_password': 'Enter password',
          'repeat_password': 'Repeat Password',
          'i_agree_to_your': 'I agree to your',
          'terms_and_policies': 'Terms & Policies',
          'create_my_account': 'Create my account',
          'message_enter_first_name': 'Please enter your first name',
          'message_enter_last_name': 'Please enter your last name',
          'message_enter_username': 'Please enter your username',
          'message_enter_valid_name': 'Please enter a valid name',
          'message_enter_phone_number': 'Please enter your phone number',
          'message_enter_valid_phone_number':
              'Please enter a valid phone number',
          'message_enter_minimum_four_digits': 'Invalid No. Minimum 4 digits.',
          'message_enter_maximum_twelve_digits':
              'Invalid No. Maximum 12 digits.',
          'enter_verification_code': 'Enter verification code',
          'otp_subtitle':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'did_not_receive_code': 'Didn’t receive the code?',
          'resend': 'Resend',
          'proceed': 'Proceed',
          'congratulations': 'Congratulations!',
          'your_account_has_been_created': 'Your account has been created',
          'welcome_to': 'Welcome to',
          'stylersin': 'Stylersin,',
          'new_password': 'New Password',
          'enter_your_email_address': 'Enter your email address',
          'forgot_password_subtitle':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'set_new_password_subtitle':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'mobile_number': 'Mobile Number',
          'enter_otp': 'Enter OTP',
          'enter_password_again': 'Enter Password again',
          'password_updated_subtitle':
              'Please login again with the newly created password.',
          'save': 'Save',
          'location_need_message':
              'We need location permission to provide services near you. Press continue to allow.',
          'message_server_error': 'Getting server error. Please try again!',
          'message_logout': 'Are you sure you want to logout from the app?',
          'email_already_exist': 'Email already exist',
          'username_already_exist': 'Username already exist',
          'phone_already_exist': 'Phone already exist',
          'message_accept_terms': 'Please accept to our terms & policies.',
          'message_password_must_be_same': 'Password must be same.',
          'code_has_been_sent_to': 'Code has been sent to email:',
          'resend_code_in': 'Resend code in',
          'password_reset_link_sent': 'Password reset link sent',
          'password_reset_link_sent_message':
              'If your email exists, password reset link has been sent to your email',
          'wrong_otp_entered': 'Wrong OTP entered',

          //main home bottom nav item titles
          'home': 'Home',
          'news_feed': 'News feed',
          'calendar': 'Calendar',
          'inbox': 'Inbox',
          'notifs': 'Notifs',
          'profile': 'Profile',
          'wallet': 'Wallet',
          'amount': 'Amount',
          'booking_history': 'Booking history',
          'settings': 'Settings',
          'turn_pro': 'Turn Pro',
          'logout': 'Logout',
          'what_are_you_looking_for': 'What are you looking for?',
          'search': 'Search',
          'services': 'Services',
          'show_all': 'Show All',
          'popular_stylists': 'Popular Stylists',
          'see_more': 'See More',
          'popular_shops': 'Popular Shops',
          'stylists': 'Stylists',
          'shops': 'Shops',
          'search_name': 'Search Name',
          'top_rated_shops': 'Top Rated Shops',
          'suggested_for_you': 'Suggested for you',
          'notification': 'Notification',
          'amount_colon': 'Amount :',
          'not_available': 'Not Available',
          'no_services': 'No Services',
          'no_stylists': 'No Stylists',
          'no_shops': 'No Shops',
          'allow_permissions': 'Allow Permissions',
          'go_to_settings':
              'Please go to settings to allow permissions manually',
          'open_settings': 'Open Settings',
          'login_required': 'Login Required',
          'login_required_message': 'Please login to continue',

          // appointment
          'appointment_cancelled_message': 'Appointment cancelled successfully',
          'no_schedule': 'No schedule',
          'service': 'Service',
          'sub_service': 'Sub-Service',
          'send_appointment_offer': 'Send appointment offer',
          'title': 'Title',
          'select_service': 'Select Service',
          'add_note': 'Add Note',
          'select_date': 'Select Date',
          'select_timeslot': 'Select Timeslot',
          'message_enter_appointment_note': 'Please write something here',
          'message_enter_appointment_title': 'Please enter title',
          'remind_me': 'Remind me',
          'add_location_required': 'Add Location (Required)',
          'name': 'Name',
          'slots_booked': 'Slots Booked',
          'total': 'Total',
          'appointment_details': 'Appointment Details',
          'service_booked': 'Service Booked',
          'payment': 'Payment',
          'note': 'Note',
          'time': 'Time',
          'location': 'Location',
          'stylist': 'Stylist',
          'pay_now': 'Pay now',
          'reserve': 'Reserve',
          'notice': 'Notice',
          'ok': 'OK',
          'cancel': 'Cancel',
          'save_changes': 'Save Changes',
          'refund': 'Refund',
          'refund_dialog_notice':
              'Are you sure that you want to refund of this booking?',
          'yes': 'Yes',
          'no': 'No',
          'your_request_has_been_received': 'Your request has been received.',
          'cancel_appointment_notice':
              'Do you really want to cancel this appointment?',
          'edit_appointment': 'Edit Appointment',
          'no_services_found': 'No services found',
          'no_free_slots': 'No Free Slots Available',
          'no_free_slots_message':
              'No free time slots available. Choose another date.',
          'tap_to_add_address':'Tap to Add Address',
          'select_sub_service':'Select Sub-Service',
          'add_location':'Add Location',
          'appointment_booked':'Appointment Booked!',
          'appointment_booked_message':'Appointment booked successfully',

          //stylist profile
          'followers': 'Followers',
          'my_followers': 'My Followers',
          'follow': 'Follow',
          'following': 'Following',
          'unfollow': 'Unfollow',
          'portfolio': 'Portfolio',
          'chat': 'Chat',
          'book_now': 'Book Now',
          'reviews': 'Reviews',
          'your_review': 'Your Review',
          'see_all_reviews': 'See all Reviews',
          'reserve_dialog_notice':
              'Your reservation will only be valid until 30 minutes before the appointment. Pay now to book.',
          'unfollow_dialog_notice':
              'You will no longer be seeing their posts and new updates from this user.',
          'no_description': 'No Description',

          //customer profile
          'your_profile': 'Your Profile',
          'edit': 'Edit',
          'email': 'Email',
          'address': 'Address',
          'message_enter_address': 'Please enter address',
          'town_city': 'Town/City',
          'state': 'State',
          'postal_code': 'Postal Code',
          'message_enter_postal_code': 'Needed',

          //payment
          'payment_methods': 'Payment Methods',
          'choose_a_payment_method': 'Choose a Payment method',
          'card_number': 'Card Number',
          'card_details': 'Card Details',
          'message_enter_card_no': 'Please enter card no',
          'message_enter_card_name': 'Please enter card name',
          'expiry_date': 'Expiry Date',
          'message_enter_expiry_date': 'Please enter expiry date',
          'cvc_number': 'CVC Number',
          'message_enter_cvc_number': 'Please enter cvc no',
          'your_payment_has_been_made': 'Your Payment has been made.',
          'delivery_message':
              'The transaction has taken place. It can take about 2-3 business days for your delivery to be processed.',

          //post
          'detailed_post': 'Post',
          'post': 'Post',
          'share_your_thoughts': 'Share your thoughts..',
          'already_added': 'Already added',
          'message_media_limit':
              'Total media content cannot be greater than 5.',
          'select_location': 'Select Location',

          //wallet
          'your_wallet': 'Your Wallet',
          'top_up_options': 'Top up options',
          'add_money': 'Add money',
          'your_balance': 'Your Balance',
          'edit_profile': 'Edit Profile',

          //settings
          'notifications': 'Notifications',
          'show_notifications': 'Show Notifications',
          'appointment_status_change_notify':
              'If Appointment status changes, Notify Me By',
          'app_notification': 'App Notification',
          'language': 'Language',
          'country': 'Country',
          'change_password': 'Change password',
          'change_password_title': 'Change Password',
          'update_password': 'Update Password',
          'enter_current_password': 'Enter Current Password',
          'password_has_been_updated': 'Password has been Updated',
          'password_changed_message':
              'Please login again with the newly created password.',

          //review
          'all_reviews': 'All Reviews',

          'messages': 'Messages',
          'unread_messages': 'Unread Messages',
          'read_messages': 'Read Messages',
          'type_your_message': 'Type your message...',
          'what_is_your_address': 'What is your address?',

          //Search Location
          'message_no_location_found_try_searching':
              'No Locations found.\nTry searching...',
          'message_loading_places':
              'Sit relaxed!!\n We are loading your places data.',
          'your_current_location': 'Your Current Location',

          //Add Address
          'your_address': 'Your Address',
          'where_can_we_find_you': 'Where can we find you?',
          'enter_your_address': 'Enter Your Address',
          'getting_address': 'Getting Address...',
          'confirm_your_address': 'Confirm Your Address',
          'street_address_line_1': 'Street Address Line 1',
          'street_address_line_2': 'Street Address Line 2',
          'city': 'City',
          'zip_code': 'Zip code',
          'continue':'Continue',

          //Post Detail
          'no_comments': 'No Comments',
          'message_empty_comment': 'Please write something',
          'type_your_comment': 'Type your comment',

          //Edit Profile
          'choose_from_gallery': 'Choose from library',
        },

//Hindi
        'hi_IN': {
          'email': 'ईमेल:',
          'enter_your_email': 'अपना मेल पता दर्ज करें',
          'login': 'लॉगिन',
          'forgot_password': 'पासवर्ड भूल गए हैं?',
          'no_account':
              'अभी तक कोई खाता नहीं है? एक नि: शुल्क 14 दिनों का परीक्षण प्राप्त करें',
          'sign_up_for_free': 'मुफ्त में साइन अप करें',
          'image_format_error': 'Only JPG And PNG Image Format Support'
        },
//arabic
        'ar_UA': {
          'email': 'البريد الإلكتروني:',
          'password': 'شعار',
          'enter_your_email': 'شعار',
          'login': 'تسجيل الدخول',
          'enter_your_password': 'أدخل عنوان بريدك الإلكتروني',
          'forgot_password': 'هل نسيت كلمة المرور؟',
          'no_account':
              'لا يوجد حساب حتى الآن؟ احصل على نسخة تجريبية مجانية لمدة 14 يوما',
          'sign_up_for_free': 'سجل مجانا'
        }
      };
}
