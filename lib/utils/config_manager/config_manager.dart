import 'package:raff/business_managers/api_model/system_config/sys_config_model.dart';

class SysConfigManager {
  static final SysConfigManager _shared = SysConfigManager._private();

  factory SysConfigManager() => _shared;

  SysConfigManager._private();

  List<SysConfigModel> _configs = [];

  set configs(List<SysConfigModel> value) {
    _configs = value;
  }

  String getValueFromKey(String key) {
    if (_configs.isEmpty) {
      return '';
    }
    try {
      String? value =
          _configs.where((element) => element.key == key).toList().first.value;
      return value ?? '';
    } catch (_) {
      return '';
    }
  }
}
