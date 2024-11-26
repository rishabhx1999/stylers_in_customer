import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stylers_in_customer/consts/app_formatters.dart';

class Validations {
  Validations._() {}

  static String? checkEmailValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_email".tr;
    } else if (!AppFormatters.validEmailExp.hasMatch(enteredValue)) {
      return 'message_invalid_email'.tr;
    } else {
      return null;
    }
  }

  static String? checkPasswordValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_password".tr;
    } else if (!AppFormatters.validPasswordExp.hasMatch(enteredValue)) {
      return 'message_enter_valid_password'.tr;
    } else {
      return null;
    }
  }

  static String? checkPasswordEmptyValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_password".tr;
    } else {
      return null;
    }
  }

  static String? checkFirstNameValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_first_name".tr;
    } else if (!AppFormatters.validNameExp.hasMatch(enteredValue)) {
      return 'message_enter_valid_name'.tr;
    } else {
      return null;
    }
  }

  static String? checkLastNameValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_last_name".tr;
    } else if (!AppFormatters.validNameExp.hasMatch(enteredValue)) {
      return 'message_enter_valid_name'.tr;
    } else {
      return null;
    }
  }

  static String? checkUsernameValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_username".tr;
    }
    /*else if(!AppFormatters.validNameExp.hasMatch(enteredValue)){
      return 'message_enter_valid_name'.tr;
    }*/
    else {
      return null;
    }
  }

  static String? checkPhoneValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_phone_number".tr;
    } else if (enteredValue.length < 4) {
      return 'message_enter_minimum_four_digits'.tr;
    } else if (enteredValue.length > 12) {
      return 'message_enter_maximum_twelve_digits'.tr;
    } else if (!AppFormatters.validPhoneExp.hasMatch(enteredValue)) {
      return 'message_enter_valid_phone_number'.tr;
    } else {
      return null;
    }
  }

  static String? checkAppointmentNoteValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_appointment_note".tr;
    } else {
      return null;
    }
  }

  static String? checkAppointmentTitleValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_appointment_title".tr;
    } else {
      return null;
    }
  }

  static String? checkCardNoValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_card_no".tr;
    } else {
      return null;
    }
  }

  static String? checkFullNameValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return 'message_enter_card_name'.tr;
    } else {
      return null;
    }
  }

  static String? checkCardExpiryValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return 'message_enter_expiry_date'.tr;
    } else {
      return null;
    }
  }

  static String? checkCardCVCValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return 'message_enter_cvc_number'.tr;
    } else {
      return null;
    }
  }

  static String? checkAddressValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return 'message_enter_address'.tr;
    } else {
      return null;
    }
  }

  static String? checkPostalCodeValidations(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return 'message_enter_postal_code'.tr;
    } else {
      return null;
    }
  }

  static String? checkConfirmPasswordValidations(
      String? value, String? password) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_enter_password".tr;
    } else if (!AppFormatters.validPasswordExp.hasMatch(enteredValue)) {
      return 'message_password_helper'.tr;
    } else if (enteredValue != password) {
      return 'message_password_must_be_same'.tr;
    } else {
      return null;
    }
  }

  static String? checkEmptyFieldValidation(String? value) {
    var enteredValue = value?.trim() ?? '';
    if (enteredValue.isEmpty) {
      return "message_filed_cannot_be_empty".tr;
    } else {
      return null;
    }
  }
}
