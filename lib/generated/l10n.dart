// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Resend Confirmation Code`
  String get resendVerificationCode {
    return Intl.message(
      'Resend Confirmation Code',
      name: 'resendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Confirmation Code in`
  String get resendConfirmationCodeIn {
    return Intl.message(
      'Resend Confirmation Code in',
      name: 'resendConfirmationCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, try again later`
  String get generalError {
    return Intl.message(
      'Something went wrong, try again later',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your credentials below`
  String get pleaseEnterYourCredentialsBelow {
    return Intl.message(
      'Please enter your credentials below',
      name: 'pleaseEnterYourCredentialsBelow',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `ZIP Code`
  String get zipCode {
    return Intl.message(
      'ZIP Code',
      name: 'zipCode',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your information below`
  String get pleaseFillYourInformationBelow {
    return Intl.message(
      'Please enter your information below',
      name: 'pleaseFillYourInformationBelow',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Account`
  String get createYourAccount {
    return Intl.message(
      'Create Your Account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your information below to reset your password`
  String get pleaseFillInYourInformationBelowToResetYourPassword {
    return Intl.message(
      'Please enter your information below to reset your password',
      name: 'pleaseFillInYourInformationBelowToResetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOtp {
    return Intl.message(
      'Enter OTP',
      name: 'enterOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code sent to the registered email address`
  String get enterTheOtpCodeSentToTheRegisteredEmailAddress {
    return Intl.message(
      'Enter the OTP code sent to the registered email address',
      name: 'enterTheOtpCodeSentToTheRegisteredEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseFillYourEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseFillYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseFillYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseFillYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your session is expired, please login again`
  String get yourSessionIsExpiredPleaseLoginAgain {
    return Intl.message(
      'Your session is expired, please login again',
      name: 'yourSessionIsExpiredPleaseLoginAgain',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Character {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Character',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get pleaseFillYourName {
    return Intl.message(
      'Please enter your full name',
      name: 'pleaseFillYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your area zip code`
  String get pleaseFillYourCountryZipcode {
    return Intl.message(
      'Please enter your area zip code',
      name: 'pleaseFillYourCountryZipcode',
      desc: '',
      args: [],
    );
  }

  /// `You created an account successfully! 🎉`
  String get youCreatedAnAccountSuccessfully {
    return Intl.message(
      'You created an account successfully! 🎉',
      name: 'youCreatedAnAccountSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code sent to your email address`
  String get enterTheOtpCodeSentToYourEmailAddress {
    return Intl.message(
      'Enter the OTP code sent to your email address',
      name: 'enterTheOtpCodeSentToYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `© {year} VINSweep. All Rights Reserved`
  String copyRight(Object year) {
    return Intl.message(
      '© $year VINSweep. All Rights Reserved',
      name: 'copyRight',
      desc: '',
      args: [year],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Latest Scans`
  String get latestScans {
    return Intl.message(
      'Latest Scans',
      name: 'latestScans',
      desc: '',
      args: [],
    );
  }

  /// `Total Sweeps`
  String get totalSweeps {
    return Intl.message(
      'Total Sweeps',
      name: 'totalSweeps',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get pleaseEnsureThatThePasswordAndConfirmPasswordFieldsMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'pleaseEnsureThatThePasswordAndConfirmPasswordFieldsMatch',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Was Reset Successfully`
  String get yourPasswordResetSuccessfully {
    return Intl.message(
      'Your Password Was Reset Successfully',
      name: 'yourPasswordResetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Scan Vehicle VIN Number`
  String get scanVehicleVinNumber {
    return Intl.message(
      'Scan Vehicle VIN Number',
      name: 'scanVehicleVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Scanned VIN Number`
  String get scannedVinNumber {
    return Intl.message(
      'Scanned VIN Number',
      name: 'scannedVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Re-Scan`
  String get rescan {
    return Intl.message(
      'Re-Scan',
      name: 'rescan',
      desc: '',
      args: [],
    );
  }

  /// `Scan your vehicle VIN number using camera`
  String get scanYourVehicleVinNumberThroughTheCamera {
    return Intl.message(
      'Scan your vehicle VIN number using camera',
      name: 'scanYourVehicleVinNumberThroughTheCamera',
      desc: '',
      args: [],
    );
  }

  /// `No Scans Yet`
  String get noScansYet {
    return Intl.message(
      'No Scans Yet',
      name: 'noScansYet',
      desc: '',
      args: [],
    );
  }

  /// `The list is currently empty`
  String get theListIsCurrentlyEmpty {
    return Intl.message(
      'The list is currently empty',
      name: 'theListIsCurrentlyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get deactivate {
    return Intl.message(
      'Deactivate',
      name: 'deactivate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your current password and new password`
  String get pleaseEnterYourCurrentPasswordAndNewPassword {
    return Intl.message(
      'Please enter your current password and new password',
      name: 'pleaseEnterYourCurrentPasswordAndNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-Type New Password`
  String get retypeNewPassword {
    return Intl.message(
      'Re-Type New Password',
      name: 'retypeNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP Code`
  String get invalidOtpValue {
    return Intl.message(
      'Invalid OTP Code',
      name: 'invalidOtpValue',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the OTP code received again`
  String get plsReEnterOtp {
    return Intl.message(
      'Please enter the OTP code received again',
      name: 'plsReEnterOtp',
      desc: '',
      args: [],
    );
  }

  /// `One Time Pin is required`
  String get oneTimePinIsRequired {
    return Intl.message(
      'One Time Pin is required',
      name: 'oneTimePinIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct name`
  String get pleaseEnterCorrectName {
    return Intl.message(
      'Please enter correct name',
      name: 'pleaseEnterCorrectName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct zip code`
  String get pleaseFillCorrectZipcode {
    return Intl.message(
      'Please enter correct zip code',
      name: 'pleaseFillCorrectZipcode',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `You can only edit your name`
  String get youCanOnlyEditYourNameAndZipCode {
    return Intl.message(
      'You can only edit your name',
      name: 'youCanOnlyEditYourNameAndZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Please select the suitable way for you to reach us`
  String get pleaseSelectTheSuitableWayForYouToReachUs {
    return Intl.message(
      'Please select the suitable way for you to reach us',
      name: 'pleaseSelectTheSuitableWayForYouToReachUs',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get callUs {
    return Intl.message(
      'Call Us',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission is required`
  String get cameraPermissionIsRequired {
    return Intl.message(
      'Camera permission is required',
      name: 'cameraPermissionIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `No VIN Detected`
  String get noVinDetectedFromTheImage {
    return Intl.message(
      'No VIN Detected',
      name: 'noVinDetectedFromTheImage',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile Was Updated Successfully`
  String get yourProfileUpdatedSuccessfully {
    return Intl.message(
      'Your Profile Was Updated Successfully',
      name: 'yourProfileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter VIN Number`
  String get pleaseFillVinNumber {
    return Intl.message(
      'Please Enter VIN Number',
      name: 'pleaseFillVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct VIN number`
  String get pleaseFillCorrectVinNumber {
    return Intl.message(
      'Please enter correct VIN number',
      name: 'pleaseFillCorrectVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Information not available`
  String get informationNotAvailable {
    return Intl.message(
      'Information not available',
      name: 'informationNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `New password must be different from the current password`
  String get newPasswordMustBeDifferentFromTheCurrentPassword {
    return Intl.message(
      'New password must be different from the current password',
      name: 'newPasswordMustBeDifferentFromTheCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Was Changed Successfully`
  String get yourPasswordChangedSuccessfully {
    return Intl.message(
      'Your Password Was Changed Successfully',
      name: 'yourPasswordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `We detected text, but not in a VIN format. Would you like to view and edit the closest one?`
  String get weDetectedTextButNoneMatchTheVinFormatWould {
    return Intl.message(
      'We detected text, but not in a VIN format. Would you like to view and edit the closest one?',
      name: 'weDetectedTextButNoneMatchTheVinFormatWould',
      desc: '',
      args: [],
    );
  }

  /// `Detected Texts`
  String get detectedTexts {
    return Intl.message(
      'Detected Texts',
      name: 'detectedTexts',
      desc: '',
      args: [],
    );
  }

  /// `Please select the closest match to edit`
  String get pleaseSelectTheMostRelevantTextToEdit {
    return Intl.message(
      'Please select the closest match to edit',
      name: 'pleaseSelectTheMostRelevantTextToEdit',
      desc: '',
      args: [],
    );
  }

  /// `By clicking confirm, recovery of your account and associated data will not be possible. This action will permanently delete all your data and account history.`
  String get deleteMessage {
    return Intl.message(
      'By clicking confirm, recovery of your account and associated data will not be possible. This action will permanently delete all your data and account history.',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Detected VINs`
  String get detectedVins {
    return Intl.message(
      'Detected VINs',
      name: 'detectedVins',
      desc: '',
      args: [],
    );
  }

  /// `Multiple VINs detected. Please select one to view vehicle information`
  String get multipleVinsDetectedPleaseSelectOneToPreviewVehicleData {
    return Intl.message(
      'Multiple VINs detected. Please select one to view vehicle information',
      name: 'multipleVinsDetectedPleaseSelectOneToPreviewVehicleData',
      desc: '',
      args: [],
    );
  }

  /// `Please grant Location permission from the App Settings to retrieve the zip code.`
  String get pleaseGrantLocationPermissionFromTheAppSettingsToRetrieve {
    return Intl.message(
      'Please grant Location permission from the App Settings to retrieve the zip code.',
      name: 'pleaseGrantLocationPermissionFromTheAppSettingsToRetrieve',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password should be only english letters`
  String get passwordShouldBeOnlyEnglishLetters {
    return Intl.message(
      'Password should be only english letters',
      name: 'passwordShouldBeOnlyEnglishLetters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number`
  String get pleaseEnterValidMobileNumber {
    return Intl.message(
      'Please enter valid mobile number',
      name: 'pleaseEnterValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your mobile number`
  String get pleaseFillYourMobileNumber {
    return Intl.message(
      'Please fill your mobile number',
      name: 'pleaseFillYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ad Title`
  String get adTitle {
    return Intl.message(
      'Ad Title',
      name: 'adTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ad Description`
  String get adDescription {
    return Intl.message(
      'Ad Description',
      name: 'adDescription',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Add item`
  String get addItem {
    return Intl.message(
      'Add item',
      name: 'addItem',
      desc: '',
      args: [],
    );
  }

  /// `Add your plastic item to be published`
  String get addYourPlasticItemToBePublished {
    return Intl.message(
      'Add your plastic item to be published',
      name: 'addYourPlasticItemToBePublished',
      desc: '',
      args: [],
    );
  }

  /// `Pick image`
  String get pickImage {
    return Intl.message(
      'Pick image',
      name: 'pickImage',
      desc: '',
      args: [],
    );
  }

  /// `تراجع`
  String get cancelAction {
    return Intl.message(
      'تراجع',
      name: 'cancelAction',
      desc: '',
      args: [],
    );
  }

  /// `Your Ads has added successfully`
  String get yourAdsHasAddedSuccessfully {
    return Intl.message(
      'Your Ads has added successfully',
      name: 'yourAdsHasAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Total Ads`
  String get totalAds {
    return Intl.message(
      'Total Ads',
      name: 'totalAds',
      desc: '',
      args: [],
    );
  }

  /// `Plastic Ads`
  String get plasticAds {
    return Intl.message(
      'Plastic Ads',
      name: 'plasticAds',
      desc: '',
      args: [],
    );
  }

  /// `No ads yet`
  String get noAdsYet {
    return Intl.message(
      'No ads yet',
      name: 'noAdsYet',
      desc: '',
      args: [],
    );
  }

  /// `معا لتعلم نشط في بيئة آمنة`
  String get learnActivly {
    return Intl.message(
      'معا لتعلم نشط في بيئة آمنة',
      name: 'learnActivly',
      desc: '',
      args: [],
    );
  }

  /// `هذه التطبيق هو عمل تطوعي من مدرسة القصور المختلطة الأولى`
  String get thisAppIs {
    return Intl.message(
      'هذه التطبيق هو عمل تطوعي من مدرسة القصور المختلطة الأولى',
      name: 'thisAppIs',
      desc: '',
      args: [],
    );
  }

  /// `My Ads`
  String get myAds {
    return Intl.message(
      'My Ads',
      name: 'myAds',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get otpCode {
    return Intl.message(
      'OTP Code',
      name: 'otpCode',
      desc: '',
      args: [],
    );
  }

  /// `Ad address:`
  String get adAddress {
    return Intl.message(
      'Ad address:',
      name: 'adAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a plastic image`
  String get pleaseUploadAPlasticImage {
    return Intl.message(
      'Please upload a plastic image',
      name: 'pleaseUploadAPlasticImage',
      desc: '',
      args: [],
    );
  }

  /// `Ad status:`
  String get adStatus {
    return Intl.message(
      'Ad status:',
      name: 'adStatus',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
