const version = 'v1';

String baseUrl = 'http://plastic-reselling.foryo.lat:8080/api/v1/';

class Apis {
  static final String login = baseUrl + 'auth/login';
  static final String register = baseUrl + 'auth/signup';
  static final String updateProfile = baseUrl + 'users/update';
  static final String deleteAccount = baseUrl + 'users/delete';
  static final String generateCode = baseUrl + 'auth/generate-otp';
  static final String verifyCode = baseUrl + 'auth/verify-otp';
  static final String sysConfig = baseUrl + 'system-config';
  static final String contact_info = baseUrl + 'setting-config/contact-us-info';
  static final String about_info = baseUrl + 'setting-config/about-us';
  static final String intro = baseUrl + 'landing-page';
  static final String resetPassword = baseUrl + 'auth/reset-password';
  static final String changePassword = baseUrl + 'auth/change-password';
  static final String scanVin = baseUrl + 'vehicle';
  static final String scanHistory = baseUrl + 'users/get-user-search-history';
  static final String forceUpdate = baseUrl + 'setting-config/app-version-info';
  static final String addAds = baseUrl + 'wares/create';
  static final String listAllWares = baseUrl + 'others-wares';
  static final String listMyWares = baseUrl + 'my-wares';
}
