import 'package:raff/business_managers/api_model/contact_info/contact_info_response.dart';
import 'package:raff/business_managers/api_model/intro/intro_response.dart';
import 'package:raff/business_managers/api_model/login/login_response.dart';
import 'package:scoped_model/scoped_model.dart';

class CurrentSession extends Model {
  CurrentSession._private();

  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  List<IntroModel> _intro = [];
  ContactInfoModel? contactInfo;
  String aboutUsText = '';
  List<IntroModel> get intro => _intro;
  UserModel? _userModel;

  set intro(List<IntroModel> value) {
    _intro = value;
    notifyListeners();
  }

  UserModel? getUser() {
    return _userModel;
  }

  bool isAuth() => _userModel != null;

  set userModel(UserModel? value) {
    _userModel = value;
  }
}
